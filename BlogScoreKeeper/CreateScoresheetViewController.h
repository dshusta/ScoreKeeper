#import <UIKit/UIKit.h>
#import "ScoresheetCollection.h"

@interface CreateScoresheetViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *player1TextField;
@property (weak, nonatomic) IBOutlet UITextField *player2TextField;
@property (weak, nonatomic) IBOutlet UITextField *player3TextField;
@property (weak, nonatomic) IBOutlet UITextField *player4TextField;
@property (weak, nonatomic) IBOutlet UITextField *player5TextField;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

- (id)initWithScoresheetCollection:(ScoresheetCollection*) scoresheetCollection;

@end
