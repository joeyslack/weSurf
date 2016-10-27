//
//  StartTableViewController.h
//  weSurf
//
//  Created by Joseph Slack on 10/26/16.
//  Copyright © 2016 Joseph Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITextField *broadcastTitle;
@property (strong, nonatomic) IBOutlet UITextField *broadcastTags;
@property (strong, nonatomic) IBOutlet UITextField *broadcastAuthor;

- (IBAction)startBroadcast:(id)sender;

@end
