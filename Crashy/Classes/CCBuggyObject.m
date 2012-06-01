#import "CCBuggyObject.h"

@implementation CCBuggyObject

- (void)dealloc
{
    delegate = nil;
    [super dealloc];
}

- (void)start
{
	NSLog(@"start step 1");
	[delegate buggyObjectWillStart:self];
	NSLog(@"start step 2");
	[delegate buggyObjectDidStart:self];	
}

- (void)stop
{
	NSLog(@"Stop step 1");
	[delegate buggyObjectWillStop:self];
	NSLog(@"Stop step 2");
	[delegate buggyObjectDidStop:self];	
}

@synthesize delegate;

@end
