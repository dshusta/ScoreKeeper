#import <UIKit/UIKit.h>

@class ScoresheetCollection;

@interface RootViewController : UITableViewController

@property (strong, nonatomic) UIButton *createNewScoresheetButton;
@property (strong, nonatomic) ScoresheetCollection *scoresheetCollection;

@end