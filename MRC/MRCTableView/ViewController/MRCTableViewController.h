//
//  MRCTableViewController.h
//  FastFood
//
//  Created by Oborn.Jung on 16/7/1.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCTableViewModel.h"
#import "MRCContanierViewController.h"

@interface MRCTableViewController : MRCContanierViewController

@property (nonatomic, strong) UITableView                   * tableView;
@property (nonatomic, strong) __kindof MRCTableViewModel    * viewModel;

@end
