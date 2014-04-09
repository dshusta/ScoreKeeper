#import <UIKit/UIKit.h>
#import "PlayerCell.h"

@class Scoresheet;
@class ScoresheetCollection;

@interface ScoresheetViewController : UIViewController <UITableViewDataSource, PlayerCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (instancetype)initWithScoreSheetCollection:(ScoresheetCollection *)scoresheetCollection
                                  scoresheet:(Scoresheet *)scoresheet;

@end
