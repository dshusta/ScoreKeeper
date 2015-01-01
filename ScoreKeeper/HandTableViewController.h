#import <UIKit/UIKit.h>
#import "Game.h"
#import "GameCollection.h"

@interface HandTableViewController : UITableViewController
@property (strong, nonatomic, readonly) GameCollection* gameCollection;
@property (strong, nonatomic, readonly) Game* game;

- (id)initWithGameCollection:(GameCollection *)gameCollection game:(Game *)game;
@end
