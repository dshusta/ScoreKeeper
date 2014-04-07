#import <UIKit/UIKit.h>
#import "ScoresheetCollection.h"

@interface CreateScoresheetViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;


- (id)initWithScoresheetCollection:(ScoresheetCollection*) scoresheetCollection;

@end
