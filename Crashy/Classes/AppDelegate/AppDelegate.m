#import "AppDelegate.h"
#import "CCRootTableViewController.h"

AppDelegate *appDelegate()
{
	return  (AppDelegate *)[UIApplication sharedApplication].delegate;
}

@implementation AppDelegate

- (void)dealloc 
{
	self.viewController = nil;
	self.window = nil;
	[super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//	while (1) {
//		NSLog(@"The happiness is endless...");
//	}
	
	_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	_window.backgroundColor = [UIColor whiteColor];
	CCRootTableViewController *rootVC = [[CCRootTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	_viewController = [[UINavigationController alloc] initWithRootViewController:rootVC];
	[rootVC release];
	[_window addSubview:_viewController.view];
	[_window makeKeyAndVisible];	
	return YES;
}

#pragma mark - Properties

@synthesize window = _window;
@synthesize viewController = _viewController;

@end
