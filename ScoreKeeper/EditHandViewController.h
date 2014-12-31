#import <UIKit/UIKit.h>
#import "Hand.h"

@class Game;
@class GameCollection;

@interface EditHandViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *playerLabels;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *pickerButtons;

@property (nonatomic, strong, readonly) Game *game;
@property (nonatomic, strong, readonly) Hand *currentHand;

- (id)initWithGameCollection:(GameCollection *)gameCollection game:(Game *)game;
- (id)initWithGameCollection:(GameCollection *)gameCollection game:(Game *)game hand:(Hand *)hand;

@end
