
@protocol EventViewDelegate;

@interface EventView : UITableView
{
    id <UITableViewDelegate, EventViewDelegate> delegate;
}

@property (nonatomic, assign) id <UITableViewDelegate, EventViewDelegate> delegate;

@end

@protocol EventViewDelegate <NSObject>
- (void)eventView:(EventView *)view flickDirection:(int)dir;
@end
