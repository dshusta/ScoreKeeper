#import <UIKit/UIKit.h>
#import "PlayerCell.h"

@class Game;
@class GameCollection;

@interface GameViewController : UITableViewController <PlayerCellDelegate>

- (instancetype)initWithGameCollection:(GameCollection *)gameCollection
                                  game:(Game *)game;

@end
