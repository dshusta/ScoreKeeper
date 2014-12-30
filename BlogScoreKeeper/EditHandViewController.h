#import <UIKit/UIKit.h>

@class Game;
@class GameCollection;

@interface EditHandViewController : UIViewController
@property (nonatomic, strong) IBOutlet UILabel* player1Label;
@property (nonatomic, strong) IBOutlet UILabel* player2Label;
@property (nonatomic, strong) IBOutlet UILabel* player3Label;
@property (nonatomic, strong) IBOutlet UILabel* player4Label;
@property (nonatomic, strong) IBOutlet UILabel* player5Label;
@property (nonatomic, strong, readonly) Game *game;

- (id)initWithGameCollection:(GameCollection *)gameCollection game:(Game *)game;

@end
