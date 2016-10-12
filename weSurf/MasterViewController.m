//
//  MasterViewController.m
//  weSurf
//
//  Created by Joseph Slack on 6/19/16.
//  Copyright © 2016 Joseph Slack. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
@import Firebase;

@interface MasterViewController ()
    @property NSMutableArray *objects;
    @property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation MasterViewController

- (IBAction)refreshControl:(id)sender {
    [self.refreshControl beginRefreshing];
    
    //  Refresh code for your TVC
    [self.refreshControl endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    //self.viewcontroller
    
    
    
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    
    self.ref = [[FIRDatabase database] reference];
    [self refreshView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    
    /*NSDate *currentDate = [NSDate date];
    NSString *key = [[_ref child:@"surfs"] childByAutoId].key;
    NSDictionary *surfObject = @{@"title": [currentDate description],
                                 @"created_at": [currentDate description],
                                 @"tags": @[@"words", @"go", @"here"],
                                 @"likes": [NSNumber numberWithInt:0],
                                 @"views": [NSNumber numberWithInt:0],
                                 @"live": [NSNumber numberWithBool:TRUE],
                                 @"offset": [NSNumber numberWithInt:0],
                                 @"key": key};
    
    [[[_ref child:@"surfs"] child:key] setValue:surfObject];
    
//    [[[[_ref child:@"surfs"] child:key] child:@"title"] setValue:[currentDate description]];
//    [[[[_ref child:@"surfs"] child:key] child:@"created_at"] setValue:[currentDate description]];
//    [[[[_ref child:@"surfs"] child:key] child:@"tags"] setValue:@{@"test": @"1"}];
//    [[[[_ref child:@"surfs"] child:key] child:@"likes"] setValue:0];
//    [[[[_ref child:@"surfs"] child:key] child:@"views"] setValue:0];
//    [[[[_ref child:@"surfs"] child:key] child:@"live"] setValue:[NSNumber numberWithBool:TRUE]];
//    [[[[_ref child:@"surfs"] child:key] child:@"offset"] setValue:@"0,0"];
    
    [self.objects insertObject:surfObject atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];*/
    
    
}

- (void)refreshView {
    //NSString *userID = [FIRAuth auth].currentUser.uid;
    
    [[_ref child:@"surfs"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        if (![snapshot.value isEqual:[NSNull null]]) {
            for (id key in snapshot.value) {
                [self.objects addObject:snapshot.value[key]];
            }
            
            [self.tableView reloadData];
        }
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDictionary *something = self.objects[indexPath.row];
    cell.textLabel.text = [something objectForKey:@"title"];
    //cell.detailTextLabel.text = @"Monkey brain";
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
