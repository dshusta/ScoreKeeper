#import <UIKit/UIKit.h>

@class Scoresheet;

@interface ScoresheetViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *player1Label;
@property (weak, nonatomic) IBOutlet UILabel *player2Label;
@property (weak, nonatomic) IBOutlet UILabel *player3Label;
@property (weak, nonatomic) IBOutlet UILabel *player4Label;
@property (weak, nonatomic) IBOutlet UILabel *player5Label;

-(ScoresheetViewController *)initWithScoresheet:(Scoresheet *)scoresheet;

@end
