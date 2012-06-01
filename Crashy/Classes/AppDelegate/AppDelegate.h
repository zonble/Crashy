#import <UIKit/UIKit.h>

@interface AppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *_window;
	UINavigationController *_viewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *viewController;

@end

AppDelegate *appDelegate();
