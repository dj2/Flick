#import "Event.h"
#import "EventView.h"

@interface EventViewController : UITableViewController <EventViewDelegate>
{
    Event *event;
}

@property (nonatomic, retain) Event *event;

@end
