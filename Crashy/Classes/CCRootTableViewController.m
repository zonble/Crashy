#import "CCRootTableViewController.h"
#import "CCBuggyViewController.h"
#import "CCBuggyDelegateViewController.h"
#import <libkern/OSAtomic.h>

@implementation CCRootTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Crashy";
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0) {
		return 6;
	}
	if (section == 1) {
		return 10;
	}
	if (section == 2) {
		return 1;
	}
	if (section == 3) {
		return 4;
	}
	if (section == 4) {
		return 1;
	}
	
	return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	if (indexPath.section == 0) {
		switch (indexPath.row) {
			case 0:
				cell.textLabel.text = @"Invalid memory reference";
				break;				
			case 1:
				cell.textLabel.text = @"Invalid memory reference";
				break;
			case 2:
				cell.textLabel.text = @"Over-release";
				break;
			case 3:
				cell.textLabel.text = @"Over-release";
				break;
			case 4:
				cell.textLabel.text = @"Over-release";
				break;
			case 5:
				cell.textLabel.text = @"Over-release";
				break;
			default:
				break;
		}
	}
	else if (indexPath.section == 1) {
		switch (indexPath.row) {
			case 0:
				cell.textLabel.text = @"Assert";
				break;
			case 1:
				cell.textLabel.text = @"NSAssert";
				break;
			case 2:
				cell.textLabel.text = @"Raise an exception";
				break;
			case 3:
				cell.textLabel.text = @"Out of bounds";
				break;				
			case 4:
				cell.textLabel.text = @"Out of bounds";
				break;
			case 5:
				cell.textLabel.text = @"Add nil to NSArray";
				break;
			case 6:
				cell.textLabel.text = @"Set object as nil to NSDictionary";
				break;
			case 7:
				cell.textLabel.text = @"Unrecognized selector";
				break;
			case 8:
				cell.textLabel.text = @"Unrecognized selector";
				break;
			case 9:
				cell.textLabel.text = @"Devide by zero";
				break;
			default:
				break;
		}
	}
	else if (indexPath.section == 2) {
		cell.textLabel.text = @"Hang";
	}
	else if (indexPath.section == 3) {
		switch (indexPath.row) {
			case 0:
				cell.textLabel.text = @"Pushing another navigation controller";
				break;
			case 1:
				cell.textLabel.text = @"Add subview";
				break;
			case 2:
				cell.textLabel.text = @"Load view";
				break;
			case 3:
				cell.textLabel.text = @"Push and pull";
				break;
			default:
				break;
		}
	}
	else if (indexPath.section == 4) {
		cell.textLabel.text = @"Buggy delegate";
	}
	
    return cell;	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		switch (indexPath.row) {
			case 0:
				NSLog(@"Let us crash at invalid memory reference");
				NSLog(@"%@", 0x1);
				break;				
			case 1:
			{
				NSData *data = [@"Let me creash" dataUsingEncoding:NSUTF8StringEncoding];
				const char *buffer;
//				buffer = calloc([data length], 1);
				[data getBytes:(void *)buffer];
				NSLog(@"%s", buffer);
			}
				break;
			case 2:
			{
				NSMutableArray *a = [NSMutableArray array];
				[a release];
				[a addObject:@"1"];
			}
			case 3:
			{
				NSMutableArray *a = [NSMutableArray array];
				[a autorelease];
			}
				break;
			case 4:
			{
				CFArrayRef a = CFArrayCreate(NULL, 0, 0, NULL);
				CFRelease(a);
				CFRelease(a);
			}
				break;
			case 5:
			{
				id x = [NSNotificationCenter defaultCenter];
				NSLog(@"%d", [x retainCount]);
				[x release];
				NSLog(@"%d", [x retainCount]);
			}
				break;
			default:
				break;
		}
	}
	else if (indexPath.section == 1) {
		switch (indexPath.row) {
			case 0:
			{
				assert(1 + 1 == 3);
			}
				break;				
			case 1:
			{
				NSAssert(1 + 1 == 3, @"Let me crash.");
			}
				break;				
			case 2:
			{
				NSException *e = [NSException exceptionWithName:@"My Exception" reason:@"Let me crash" userInfo:nil];
				[e raise];
			}
				break;				
			case 3:
			{
				NSArray *a = [NSArray arrayWithObjects:@"1", @"2", nil];
				[a objectAtIndex:3];
			}
				break;				
			case 4:
			{
				[@"Hi" characterAtIndex:12];
			}
				break;
			case 5:
			{
				NSMutableArray *a = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
				[a addObject:nil];
			}
				break;
			case 6:
			{
				NSMutableDictionary *d = [NSMutableDictionary dictionary];
				[d setObject:nil forKey:@"key"];
			}
				break;
			case 7:
			{
				[@"Hi" performSelector:@selector(letMeCrash)];
			}
				break;
			case 8:
			{
				NSArray *a = (NSArray *)@"Hi";
				for (id x in a) {
					NSLog(@"obj:%@", x);
				}
			}
			case 9:
			{
				NSDecimalNumber *a = [NSDecimalNumber decimalNumberWithString:@"1"];
				NSDecimalNumber *b = [NSDecimalNumber decimalNumberWithString:@"0"];
				[a decimalNumberByDividingBy:b];
			}
				break;
			default:
				break;
		}
	}
	else if (indexPath.section == 2) {
		OSSpinLock lock = OS_SPINLOCK_INIT;
		OSSpinLockLock(&lock);
		OSSpinLockLock(&lock);
		OSSpinLockUnlock(&lock);
	}
	else if (indexPath.section == 3) {
		switch (indexPath.row) {
			case 0:
			{
				UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:nil];
				[self.navigationController pushViewController:navController animated:YES];
				[navController release];
			}
				break;				
			case 1:
			{
				UIView *aView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)] autorelease];
				[aView addSubview:aView];
			}
				break;
			case 2:
			{
				CCBuggyViewController *viewController = [[CCBuggyViewController alloc] init];
				[self.navigationController pushViewController:viewController animated:YES];
			}
				break;
			case 3:
			{
				UIViewController *viewController = [[UIViewController alloc] init];
				[self.navigationController pushViewController:viewController animated:YES];
				[self.navigationController performSelector:@selector(popToRootViewControllerAnimated:) withObject:nil afterDelay:0.1];
				[viewController release];
			}
				break;
			default:
				break;
		}
	}
	else if (indexPath.section == 4) {
		CCBuggyDelegateViewController *viewController = [[CCBuggyDelegateViewController alloc] initWithNibName:NSStringFromClass([CCBuggyDelegateViewController class]) bundle:nil];
		[self.navigationController pushViewController:viewController animated:YES];
	}
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	switch (section) {
		case 0:
			return @"Memory management";
		case 1:
			return @"Exceptions";
		case 2:
			return @"Hang";
		case 3:
			return @"UIKit";
		case 4:
			return @"Buggy Delegate";
		default:
			break;
	}
	return nil;
}

@end
