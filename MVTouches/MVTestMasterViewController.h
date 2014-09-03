//
//  MVTestMasterViewController.h
//  MVTouches
//
//  Created by Michael on 9/2/14.
//  Copyright (c) 2014 MichaelVoznesensky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MVTestDetailViewController;

@interface MVTestMasterViewController : UITableViewController

@property (strong, nonatomic) MVTestDetailViewController *detailViewController;

@end
