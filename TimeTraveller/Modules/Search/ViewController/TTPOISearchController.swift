//
//  TTPOISearchController.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/27/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import OBUIKit

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
    }
    
    override func loadView() {
        self.view = self.tableView;
    }
    
    override func setupViews() {
        self.edgesForExtendedLayout = .None;
        /**
        *    setup table view
        */
        self.dataSource = TTPOISearchDataSource(tableView: self.tableView);
        self.dataSource.cellInterceptor = self;
        self.tableView.delegate   = self;
        self.tableView.dataSource = self.dataSource
        self.tableView.backgroundColor = TT_GrayBg_Color;
        self.tableView.separatorStyle = .None;
        let footer = UIButton(type: .System);
        footer.setTitle("清空搜索历史", forState: .Normal);
        footer.frame.size = CGSizeMake(200, 40);
        self.tableView.tableFooterView = footer;
        self.tableView.showsVerticalScrollIndicator = false;
        /**
        *    setup poi search engine
        */
        self.poiSearchEngine = TTPOIEngine(dataSource: self.dataSource);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "upScreenNotifacationHandler:", name: kTTUpScreenNotification, object: nil);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated);
        self.view.hidden = false;
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
        self.searchController = searchController;
        searchController.searchBar.delegate = searchController.searchBar.delegate ?? self;
        let searchWord = searchController.searchBar.text ?? "";
        if searchWord.isEmpty {
            self.dataSource.setDataSource(nil);
        } else {
            self.poiSearchEngine.updateSuggestion(searchWord, region: self.searchRegion);
            self.poiSearchEngine.updateSuggestion(searchWord, region: self.searchRegion, completion: { (object: [[OBBaseComponentModel]]?) -> Void in
                
            })
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
            self.searchController?.searchBar.text = poiCell.poiName.text;
        }
    }
    
    //MARK: - UISearchBarDelegate
    // return NO to not resign first responder
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        
        self.selectedPoi = (self.dataSource.firstObject as? TTPOIModel)?.poi;
        dispatch_async(dispatch_get_main_queue()) {[weak self] () -> Void in
            self?.dismissViewControllerAnimated(true, completion: nil);
        };
        return true;
    }
//    // return NO to not become first responder
//    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
//        return true;
//    }
//    // called when text starts editing
//    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
//        
//    }
//    // called when text ends editing
//    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
//        
//    }
//    // called when text changes (including clear)
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        
//    }
//    
//    // called when keyboard search button pressed
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        
//    }
//    // called when bookmark button pressed
//    func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
//        
//    }
//    // called when cancel button pressed
//    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//        
//    }
//    // called when search results button pressed
//    func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
//        
//    }
    
    //MARK: Notification handler
    func upScreenNotifacationHandler(notifacation: NSNotification) {
        if let searchWord = notifacation.userInfo?["word"] as? String {
            self.searchController?.searchBar.text = searchWord;
        }
    }
}


