//
//  DetailViewController.m
//  weSurf
//
//  Created by Joseph Slack on 6/19/16.
//  Copyright © 2016 Joseph Slack. All rights reserved.
//

#import "DetailViewController.h"
@import Firebase;

@interface DetailViewController ()
    @property (strong, nonatomic) IBOutlet UIWebView *webView;
    @property (strong, nonatomic) FIRDatabaseReference *ref;
@end

FIRDatabaseHandle _refHandle;

@implementation DetailViewController

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.navigationItem.title = [[self.detailItem objectForKey:@"title"] description];
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.webView.scrollView.scrollEnabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.ref = [[FIRDatabase database] reference];
    [self configureView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Handle new page navigation
    _refHandle = [[[[[_ref child:@"surfs"] child:[self.detailItem objectForKey:@"key"]] child:@"pages"] queryLimitedToFirst:1] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        //_refHandle = [[_ref child:@"surfs"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        //_refHandle = [_ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {

        if (![snapshot.value isEqual:[NSNull null]]) {
            NSDictionary *postDict = snapshot.value;
            
            if (self.navigationItem.title != [[postDict objectForKey:@"page1"] objectForKey:@"title"]) {
                self.navigationItem.title = [[postDict objectForKey:@"page1"] objectForKey:@"title"];
            }
            
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[postDict objectForKey:@"page1"] objectForKey:@"url"]]]];
        }
    }];
    
    // Handle content scrolling event
    FIRDatabaseHandle offsetRef = [[[[_ref child:@"surfs"] child:[self.detailItem objectForKey:@"key"]] child:@"offset"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        if (![snapshot.value isEqual:[NSNull null]]) {
            [self.webView.scrollView setContentOffset:CGPointMake(0, [snapshot.value intValue]) animated:YES];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(NSDictionary *)newDetailItem {
    
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

@end
