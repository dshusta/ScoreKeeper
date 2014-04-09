#import <UIKit/UIKit.h>

@class Scoresheet;

@interface ScoresheetViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (ScoresheetViewController *)initWithScoresheet:(Scoresheet *)scoresheet;



@end
