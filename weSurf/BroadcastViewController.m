//
//  BroadcastViewController.m
//  
//
//  Created by Joseph Slack on 10/26/16.
//
//

#import "BroadcastViewController.h"
#import "DZNWebViewController.h"
@import Firebase;

@interface BroadcastViewController ()
    @property UISearchBar *searchBar;
    @property UISearchController *searchCon;
    @property KINWebBrowserViewController *webBrowser;
    @property NSString *firebaseKey;

    @property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation BroadcastViewController


- (id) initWithKey:(NSString *)key {
    // Call superclass's initializer
    self = [super init];
    if( !self ) return nil;
    
    self.firebaseKey = key;
    self.ref = [[FIRDatabase database] reference];
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
    // Make search bar
    self.searchBar = [[UISearchBar alloc] init];
    [self.searchBar setBarStyle:UIBarStyleDefault];
    [self.searchBar setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    self.searchBar.delegate = self;

    UINavigationController *webBrowserNavigationController = [KINWebBrowserViewController navigationControllerWithWebBrowser];
    //webBrowserNavigationController.navigationController.navigationBar.translucent = NO;
    //[webBrowserNavigationController.navigationController.navigationBar setBarTintColor:[UIColor greenColor]];
    [self presentViewController:webBrowserNavigationController animated:NO completion:nil];
    
    self.webBrowser = [webBrowserNavigationController rootWebBrowser];
    [self.webBrowser loadURLString:@"https://cf.geekdo-images.com/images/pic237586_md.jpg"];

    self.webBrowser.navigationItem.titleView = self.searchBar;
    
    //self.webBrowser.uiWebView.scrollView.delegate = self;
    self.webBrowser.wkWebView.scrollView.delegate = self;*/
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchString = [searchBar text];
    
    // Let's assume http if user enters www
    if ([searchString hasPrefix:@"www."]) {
        searchString = [@"http://" stringByAppendingString:searchString];
        [self.webBrowser loadURLString:searchString];
    }
    // Probably a search term
    else if (![searchString hasPrefix:@"http://"]) {
        searchString = [@"http://www.google.com/search?q=" stringByAppendingString:[NSString stringWithUTF8String:[searchString UTF8String]]];
        //searchString = @"http://www.google.com/search?q=" + [searchString UTF8String]
    }
    
    [self.webBrowser loadURLString:searchString];
}


/* 
 #pragma mark DELEGATIONS
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"SCROLLING DONE %@", @(scrollView.contentOffset.y));
    [[[[_ref child:@"surfs"] child:self.firebaseKey] child:@"offset"] setValue:@(scrollView.contentOffset.y)];
}

/*- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
 
}*/

- (void)webBrowser:(KINWebBrowserViewController *)webBrowser didStartLoadingURL:(NSURL *)URL {
    [[[[[[_ref child:@"surfs"] child:self.firebaseKey] child:@"pages"] child:@"page1"] child:@"url"] setValue:[URL absoluteString]];
}
- (void)webBrowser:(KINWebBrowserViewController *)webBrowser didFinishLoadingURL:(NSURL *)URL {
    
}
- (void)webBrowser:(KINWebBrowserViewController *)webBrowser didFailToLoadURL:(NSURL *)URL withError:(NSError *)error {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
