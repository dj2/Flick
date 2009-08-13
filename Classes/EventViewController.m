#import "EventViewController.h"

@implementation EventViewController

@synthesize event;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    static NSString *LocationCellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LocationCellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:LocationCellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateStyle:NSDateFormatterLongStyle];

    cell.textLabel.text = [dateFormat stringFromDate:event.timeStamp];
    
    return cell;
}

- (void)dealloc
{
    [event dealloc];
    [super dealloc];
}

@end
