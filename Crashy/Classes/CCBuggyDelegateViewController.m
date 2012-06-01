#import "CCBuggyDelegateViewController.h"

@interface CCBuggyDelegateViewController ()

@end

@implementation CCBuggyDelegateViewController

- (void)dealloc
{
	self.startButton = nil;
	[obj release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	self.startButton = nil;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		obj = [[CCBuggyObject alloc] init];
		obj.delegate = self;
    }
    return self;
}

- (IBAction)start:(id)sender
{
	[obj start];
}

- (void)buggyObjectWillStart:(CCBuggyObject *)inObject
{
	NSLog(@"%s", __PRETTY_FUNCTION__);
	[inObject start];
//	[inObject stop];
}
- (void)buggyObjectDidStart:(CCBuggyObject *)inObject
{
	NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)buggyObjectWillStop:(CCBuggyObject *)inObject
{
	NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)buggyObjectDidStop:(CCBuggyObject *)inObject
{
	NSLog(@"%s", __PRETTY_FUNCTION__);
}

@synthesize startButton;
@synthesize obj;

@end
