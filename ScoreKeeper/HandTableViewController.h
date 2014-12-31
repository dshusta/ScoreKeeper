#import <UIKit/UIKit.h>
#import "Game.h"

@class GameCollection;

@interface HandTableViewController : UITableViewController
@property (strong, nonatomic, readonly) Game* game;

- (id)initWithGameCollection:(GameCollection *)gameCollection game:(Game *)game;
@end
