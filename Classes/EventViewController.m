#import <QuartzCore/QuartzCore.h>
#import "EventViewController.h"
#import "RootViewController.h"

@implementation EventViewController

@synthesize event;

- (void)loadView
{
    EventView *eventView = [[[EventView alloc] initWithFrame:CGRectZero
                                                       style:UITableViewStyleGrouped] autorelease];
    [eventView setDelegate:self];
    [eventView setDataSource:self];

    self.view = eventView;
    self.tableView = eventView;
}

- (void)viewDidLoad
{
    self.navigationItem.title = @"Event Info";
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *LocationCellIdentifier = @"Timestamp";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LocationCellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:LocationCellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateStyle:NSDateFormatterLongStyle];
    [dateFormat setTimeStyle:NSDateFormatterLongStyle];

    cell.textLabel.text = [dateFormat stringFromDate:event.timeStamp];
    
    return cell;
}

- (void)addAnimation:(NSString *)name subtype:(NSString *)subtype duration:(float)duration
               start:(float)start end:(float)end delegate:(id)animDelegate
{
    CATransition *anim = [CATransition animation];
    
    [anim setDuration:duration];
    [anim setType:kCATransitionPush];
    [anim setSubtype:subtype];
    [anim setStartProgress:start];
    [anim setEndProgress:end];
    [anim setDelegate:animDelegate];
    [anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    [[[self.view superview] layer] addAnimation:anim forKey:name];
}

- (void)eventView:(EventView *)view flickDirection:(int)dir
{
    NSFetchedResultsController *frc = [[[self.navigationController viewControllers] objectAtIndex:0] fetchedResultsController];
    
    NSIndexPath *path = [frc indexPathForObject:[self event]];
    NSInteger row = [path row];
    
    if ((dir == -1) && (row > 0)) row --;
    else if ((dir == 1) && (row < ([[frc fetchedObjects] count] - 1))) row ++;

    if (row == [path row])
    {
        [self addAnimation:@"PushHalfOut"
                   subtype:(dir == -1 ? kCATransitionFromLeft : kCATransitionFromRight)
                  duration:0.25
                     start:0.0
                       end:0.25
                  delegate:self];
        return;
    }

    NSIndexPath *newPath = [NSIndexPath indexPathForRow:row inSection:[path section]];
    [self setEvent:[frc objectAtIndexPath:newPath]];

    [self.tableView reloadData];
    
    [self addAnimation:@"SwitchView"
               subtype:(dir == -1 ? kCATransitionFromLeft : kCATransitionFromRight)
              duration:0.5
                 start:0.0
                   end:1.0
              delegate:nil];
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    [self addAnimation:@"PushHalfIn"
               subtype:[(CATransition *)animation subtype]
              duration:0.25
                 start:0.25
                   end:0.0
              delegate:nil];
}

- (void)dealloc
{
    [super dealloc];
}

@end
