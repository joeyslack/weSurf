//
//  DetailViewController.h
//  weSurf
//
//  Created by Joseph Slack on 6/19/16.
//  Copyright © 2016 Joseph Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

