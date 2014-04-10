#import <UIKit/UIKit.h>
#import "PlayerCell.h"

@class Scoresheet;
@class ScoresheetCollection;

@interface ScoresheetViewController : UITableViewController <PlayerCellDelegate>

- (instancetype)initWithScoreSheetCollection:(ScoresheetCollection *)scoresheetCollection
                                  scoresheet:(Scoresheet *)scoresheet;

@end
