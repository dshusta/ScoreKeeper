#import <UIKit/UIKit.h>
#import "PlayerCell.h"

@class Scoresheet;

@interface ScoresheetViewController : UIViewController <UITableViewDataSource, PlayerCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (ScoresheetViewController *)initWithScoresheet:(Scoresheet *)scoresheet;

@end
