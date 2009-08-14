#import "EventView.h"

#define MIN_FLICK_DISTANCE 10.0

@implementation EventView

@synthesize delegate;

- (int)flicked:(UITouch *)touch
{
    CGPoint start = [touch previousLocationInView:self];
    CGPoint end = [touch locationInView:self];
    
    double x = end.x - start.x;
    double y = end.y - start.y;
    double dist = sqrt((x * x) + (y * y));
    
    if (dist > MIN_FLICK_DISTANCE)
    {
        if (end.x < start.x) return 1;
        else return -1;
    }
    return 0;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    int dir = [self flicked:touch];
    
    if (dir != 0) [self.delegate eventView:self flickDirection:dir];
    
    [super touchesEnded:touches withEvent:event];
}

- (void)dealloc
{
    [super dealloc];
}

@end
