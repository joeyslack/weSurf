//
//  BroadcastViewController.h
//  
//
//  Created by Joseph Slack on 10/26/16.
//
//

#import <UIKit/UIKit.h>
#import <KINWebBrowser/KINWebBrowserViewController.h>

@interface BroadcastViewController : UIViewController <KINWebBrowserDelegate, UISearchBarDelegate, UIScrollViewDelegate>

- (id) initWithKey:(NSString *)key;

@end
