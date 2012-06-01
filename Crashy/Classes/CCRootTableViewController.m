#import "CCRootTableViewController.h"
#import <libkern/OSAtomic.h>

@implementation CCRootTableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0) {
		return 3;
	}
	if (section == 1) {
		return 7;
	}
	if (section == 2) {
		return 1;
	}
	if (section == 3) {
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
				cell.textLabel.text = @"Over-release";
				break;
			case 2:
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
				cell.textLabel.text = @"Out of bound";
				break;				
			case 4:
				cell.textLabel.text = @"Add nil to NSArray";
				break;
			case 5:
				cell.textLabel.text = @"Set object as nil to NSDictionary";
				break;
			case 6:
				cell.textLabel.text = @"Unrecognized selector";
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
			default:
				break;
		}
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
				NSMutableArray *a = [NSMutableArray array];
				[a release];
				[a addObject:@"1"];
			}
			case 2:
			{
				NSMutableArray *a = [NSMutableArray array];
				[a autorelease];
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
				NSMutableArray *a = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
				[a addObject:nil];
			}
				break;
			case 5:
			{
				NSMutableDictionary *d = [NSMutableDictionary dictionary];
				[d setObject:nil forKey:@"key"];
			}
				break;
			case 6:
			{
				[@"Hi" performSelector:@selector(letMeCrash)];
			}
				break;
			default:
				break;
		}
	}
	else if (indexPath.section == 2) {
		OSSpinLock lock = OS_SPINLOCK_INIT;
		OSSpinLockLock(&lock);
//		OSSpinLockLock(&lock);
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
			default:
				break;
		}
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
		default:
			break;
	}
	return nil;
}

@end
