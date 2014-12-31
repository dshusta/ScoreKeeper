#import <UIKit/UIKit.h>
#import "Hand.h"

@class Game;
@class GameCollection;

@interface EditHandViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *playerLabels;

@property (nonatomic, strong) IBOutlet UIButton* player1PickerButton;
@property (nonatomic, strong) IBOutlet UIButton* player2PickerButton;
@property (nonatomic, strong) IBOutlet UIButton* player3PickerButton;
@property (nonatomic, strong) IBOutlet UIButton* player4PickerButton;
@property (nonatomic, strong) IBOutlet UIButton* player5PickerButton;

@property (nonatomic, strong, readonly) Game *game;
@property (nonatomic, strong, readonly) Hand *currentHand;

- (id)initWithGameCollection:(GameCollection *)gameCollection game:(Game *)game;
- (id)initWithGameCollection:(GameCollection *)gameCollection game:(Game *)game hand:(Hand *)hand;

@end
