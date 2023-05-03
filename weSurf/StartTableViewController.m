//
//  StartTableViewController.m
//  weSurf
//
//  Created by Joseph Slack on 10/26/16.
//  Copyright © 2016 Joseph Slack. All rights reserved.
//

#import "StartTableViewController.h"
#import "DZNWebViewController.h"
#import "BroadcastViewController.h"
@import Firebase;

@interface StartTableViewController ()
     @property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation StartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.ref = [[FIRDatabase database] reference];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


// Start the broadcast button
// TODO: Add some type of form validation for this step
- (IBAction)startBroadcast:(id)sender {
    
    // Add new "surf" entry in firebase
    NSDate *currentDate = [NSDate date];
    NSString *key = [[_ref child:@"surfs"] childByAutoId].key;
    NSDictionary *surfObject = @{@"title": [_broadcastTitle text],
                                 @"created_at": [currentDate description],
                                 @"tags": [[_broadcastTags text] componentsSeparatedByString:@" "],
                                 @"likes": [NSNumber numberWithInt:0],
                                 @"views": [NSNumber numberWithInt:0],
                                 @"live": [NSNumber numberWithBool:TRUE],
                                 @"offset": [NSNumber numberWithInt:0],
                                 @"author": [_broadcastAuthor text],
                                 @"key": key};
    
    [[[_ref child:@"surfs"] child:key] setValue:surfObject];
    
    
    BroadcastViewController *bvc = [[BroadcastViewController alloc] initWithKey:key];
    [self.navigationController pushViewController:bvc animated:NO];
    
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //BroadcastViewController *myVC = (BroadcastViewController *)[storyboard instantiateViewControllerWithIdentifier:@"myViewCont"];

    
}

@end
