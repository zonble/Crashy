@class CCBuggyObject;

@protocol CCBuggyObjectDelegate <NSObject>
@required
- (void)buggyObjectWillStart:(CCBuggyObject *)inObject;
- (void)buggyObjectDidStart:(CCBuggyObject *)inObject;
- (void)buggyObjectWillStop:(CCBuggyObject *)inObject;
- (void)buggyObjectDidStop:(CCBuggyObject *)inObject;

@end

@interface CCBuggyObject : NSObject
{
	id <CCBuggyObjectDelegate> delegate;
}

- (void)start;
- (void)stop;

@property (assign, nonatomic) id <CCBuggyObjectDelegate> delegate;

@end
