//
//  MVTestDetailViewController.h
//  MVTouches
//
//  Created by Michael on 9/2/14.
//  Copyright (c) 2014 MichaelVoznesensky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVTestDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
