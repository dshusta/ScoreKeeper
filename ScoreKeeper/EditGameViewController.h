#import <UIKit/UIKit.h>
#import "Game.h"
#import "GameCollection.h"

@interface EditGameViewController : UIViewController

@property (strong, nonatomic) Game *game;
@property (strong, nonatomic) GameCollection *gameCollection;

@property (weak, nonatomic) IBOutlet UILabel *gameNameLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *playerNameLabels;

- (instancetype)initWithGameCollection:(GameCollection *)collection game:(Game *)game;

@end
