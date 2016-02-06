//
//  TTPOISearchController.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/27/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import MapKit
import OBUIKit
import ReactiveCocoa;
import HZActivityIndicatorView

extension UISearchBar {
    
    private struct AssociatedKeys {
        static var loadingView   = "tt_loadingView";
        static var searchLoading = "tt_searchLoading";
    }
    
    var searchLoading: Bool {
        get {
            return (objc_getAssociatedObject(self, &(AssociatedKeys.searchLoading)) as? Bool) ?? false;
        } set {
            if newValue != self.searchLoading {
                if newValue {
                    let blankIcon = UIImage.ob_imageWithColor(UIColor.clearColor(), size: CGSizeMake(1, 1));
                    self.setImage(blankIcon, forSearchBarIcon: .Search, state: .Normal);
                    let loadingView = HZActivityIndicatorView(activityIndicatorStyle: .Gray);
                    loadingView.steps = 11;
                    loadingView.finSize = CGSizeMake(1.5, 4.5);
                    self.addSubview(loadingView);
                    loadingView.snp_makeConstraints(closure: { (make) -> Void in
                        make.centerY.equalTo(self);
                        make.leading.equalTo(self).offset(7);
                        make.size.equalTo(CGSizeMake(16, 16));
                    });
                    loadingView.startAnimating();
                    objc_setAssociatedObject(self, &(AssociatedKeys.loadingView), loadingView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                } else {
                    if let loadingView = objc_getAssociatedObject(self, &(AssociatedKeys.loadingView)) as? HZActivityIndicatorView {
                        loadingView.stopAnimating();
                        loadingView.removeFromSuperview();
                        objc_setAssociatedObject(self, &(AssociatedKeys.loadingView), nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                    }
                    self.setImage(nil, forSearchBarIcon: .Search, state: .Normal);
                }
                objc_setAssociatedObject(self, &(AssociatedKeys.searchLoading), newValue, .OBJC_ASSOCIATION_RETAIN);
            }
        }
    }
    
}

class TTPOISearchController: TTBaseViewController, UISearchResultsUpdating, UISearchBarDelegate,
                             UITableViewDelegate, OBTableCellMappingProtocol, AMapSearchDelegate {
    
    var searchRegion: MKCoordinateRegion?;
    private(set) var selectedPoi: TTPOIModel?;
    
    private let tableView  = UITableView();
    private var viewModel: TTPOIViewModel!;
    private weak var searchDisposable: RACDisposable?;
    private weak var searchController: UISearchController?;
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
        self.tableView.ob_setAccommodateKeyboard(false);
    }
    
    override func setupViews() {
        self.edgesForExtendedLayout = .Bottom;
        self.view.backgroundColor   = UIColor.clearColor();
        /**
        *    setup background view
        */
        let blurEffect = UIBlurEffect(style: .Light);
        let blurView = UIVisualEffectView(effect: blurEffect);
        self.view.addSubview(blurView);
        blurView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view);
        }
        /**
        *    setup table view
        */
        self.viewModel = TTPOIViewModel(tableView: self.tableView);
        self.viewModel.cellInterceptor = self;
        self.tableView.delegate   = self;
        self.tableView.dataSource = self.viewModel
        self.tableView.backgroundColor = UIColor.clearColor();
        self.tableView.separatorStyle = .None;
        self.tableView.ob_setAccommodateKeyboard(true);
        let footer = UIButton(type: .System);
        footer.setTitle("清空搜索历史", forState: .Normal);
        footer.frame.size = CGSizeMake(0, 40);
        self.tableView.tableFooterView = footer;
        self.tableView.indicatorStyle = .Black;
        self.tableView.showsVerticalScrollIndicator = true;
        self.view.addSubview(self.tableView);
        self.tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view);
        }
        /**
        *    setup poi search engine
        */
        NSNotificationCenter.defaultCenter().rac_addObserverForName(kTTUpScreenNotification, object: nil).subscribeNext {[weak self] (object: AnyObject!) -> Void in
            if let searchWord = (object as? NSNotification)?.userInfo?["word"] as? String {
                self?.searchController?.searchBar.text = searchWord;
            }
        }
        
        self.bindSearchResult();
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.selectedPoi = nil;
    }
    
    //MARK: - OBTableCellMappingProtocol
    func cellClassForModel(model: OBBaseComponentModel!) -> AnyClass! {
        if let tag = model.tag {
            switch tag {
            case kTTPOIModelKey:
                return TTPOICell.self;
            default:
                break;
            }
        }
        return nil;
    }
    
    func bindSearchResult() {
        self.rac_signalForSelector("updateSearchResultsForSearchController:", fromProtocol: NSProtocolFromString("UISearchResultsUpdating")).throttle(0.3).subscribeNext {[weak self] (object: AnyObject!) -> Void in
            if let strongSelf = self {
                if let tuple = object as? RACTuple {
                    let searchController = tuple.first as! UISearchController;
                    let searchWord = searchController.searchBar.text ?? "";
                    if searchWord.isEmpty {
                        strongSelf.viewModel.setDataSource(nil);
                        searchController.searchBar.searchLoading = false;
                    } else {
                        searchController.searchBar.searchLoading = true;
                        let searchParams = TTPOISearchParams(searchKeywords:searchWord, searchRegion:strongSelf.searchRegion!);
                        if let disposable = strongSelf.searchDisposable {
                            disposable.dispose();
                        }
                        strongSelf.searchDisposable = strongSelf.viewModel.updateSugCommand.execute(searchParams).deliverOn(RACScheduler.mainThreadScheduler()).subscribeError({ (error: NSError!) -> Void in
                            searchController.searchBar.searchLoading = false;
                            var description: String!;
                            AMapSearchErrorCode.TimeOut
                            switch (error.domain, AMapSearchErrorCode(rawValue: error.code) ?? AMapSearchErrorCode.Unknown) {
                            case ("RACCommandErrorDomain", _):
                                description = "😭我跟不上您的速度啦";
                            case (_, .OK), (_, .Cancelled):
                                description = nil;
                            case (_, .TimeOut):
                                description = "网络超时，请重试！";
                            case (_, .NotConnectedToInternet):
                                description = "网络连接失败，请检查网络！";
                            default:
                                description = "服务器ooxx啦，请稍后重试！"
                            }
                            
                            if let errorDescription = description {
                                OBShowToast(errorDescription);
                            }
                            }, completed: { () -> Void in
                                searchController.searchBar.searchLoading = false;
                        });
                    }
                }
            }
        }
    }
    
    //MARK: - UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.view.hidden = false;
        self.searchController = searchController;
    }
    
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.viewModel.tableView(tableView, heightForRowAtIndexPath: indexPath);
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false);
        if let poiModel = self.viewModel.modelWithIndexPath(indexPath) as? TTPOIModel {
            self.selectedPoi = poiModel;
            self.searchController?.searchBar.resignFirstResponder();
        }
    }
    
    //MARK: - UISearchBarDelegate
    // return NO to not resign first responder
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        dispatch_async(dispatch_get_main_queue()) {[weak self] () -> Void in
            self?.searchController?.active = false;
        };
        return true;
    }

    // called when keyboard search button pressed
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let poiModel = self.viewModel.firstObject as? TTPOIModel {
            self.selectedPoi = poiModel;
            self.searchController?.searchBar.resignFirstResponder();
        }
    }
}


