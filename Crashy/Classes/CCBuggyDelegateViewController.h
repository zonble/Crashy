#import "CCBuggyObject.h"

@interface CCBuggyDelegateViewController : UIViewController <CCBuggyObjectDelegate>
{
	UIButton *startButton;
	CCBuggyObject *obj;
}

- (IBAction)start:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *startButton;
@property (retain, nonatomic) CCBuggyObject *obj;

@end
