//
//  TTPOISearchController.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/27/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import OBUIKit
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
                    objc_setAssociatedObject(self, &(AssociatedKeys.loadingView), loadingView, .OBJC_ASSOCIATION_RETAIN);
                } else {
                    if let loadingView = objc_getAssociatedObject(self, &(AssociatedKeys.loadingView)) as? HZActivityIndicatorView {
                        loadingView.stopAnimating();
                        loadingView.removeFromSuperview();
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
    private(set) var selectedPoi: AMapPOI?;
    
    private let tableView  = UITableView();
    private var poiSearchEngine: TTPOIEngine!;
    private var dataSource: TTPOISearchDataSource!;
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
        self.dataSource = TTPOISearchDataSource(tableView: self.tableView);
        self.dataSource.cellInterceptor = self;
        self.tableView.delegate   = self;
        self.tableView.dataSource = self.dataSource
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
        self.poiSearchEngine = TTPOIEngine(dataSource: self.dataSource);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "upScreenNotifacationHandler:", name: kTTUpScreenNotification, object: nil);
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
    
    //MARK: - UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.view.hidden = false;
        self.searchController = searchController;
        searchController.searchBar.delegate = searchController.searchBar.delegate ?? self;
        let searchWord = searchController.searchBar.text ?? "";
        if searchWord.isEmpty {
            self.poiSearchEngine.cancelUpdate();
            self.dataSource.setDataSource(nil);
            searchController.searchBar.searchLoading = false;
        } else {
            searchController.searchBar.searchLoading = true;
            self.poiSearchEngine.updateSuggestion(searchWord, region: self.searchRegion, completion: { (object: [[OBBaseComponentModel]]?, error: NSError?) -> Void in
                searchController.searchBar.searchLoading = false;
                
                if let errorCode = (error != nil ? AMapSearchErrorCode(rawValue: error!.code) : nil) {
                    var description: String? = nil;
                    switch errorCode {
                    case .OK, .Cancelled:
                        description = nil;
                    case .TimeOut:
                        description = "网络超时，请重试！";
                    case .NotConnectedToInternet:
                        description = "网络连接失败，请检查网络！";
                    default:
                        description = "服务器ooxx啦，请稍后重试！"
                    }
                    
                    if let errorDescription = description {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            OBShowToast(errorDescription);
                        })
                    }
                }
            });
        }
        OBLog("\(searchController.searchBar.text)");
    }
    
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.dataSource.tableView(tableView, heightForRowAtIndexPath: indexPath);
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false);
        if let poiCell = tableView.cellForRowAtIndexPath(indexPath) as? TTPOICell {
            self.selectedPoi = poiCell.poiModel?.poi;
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
        if let poiModel = (self.dataSource.firstObject as? TTPOIModel)?.poi {
            self.selectedPoi = poiModel;
            self.searchController?.searchBar.resignFirstResponder();
        }
    }
    
    //MARK: Notification handler
    func upScreenNotifacationHandler(notifacation: NSNotification) {
        if let searchWord = notifacation.userInfo?["word"] as? String {
            self.searchController?.searchBar.text = searchWord;
        }
    }
}


