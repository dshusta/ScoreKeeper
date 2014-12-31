#import <UIKit/UIKit.h>
#import "GameCollection.h"

@interface CreateGameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *player1TextField;
@property (weak, nonatomic) IBOutlet UITextField *player2TextField;
@property (weak, nonatomic) IBOutlet UITextField *player3TextField;
@property (weak, nonatomic) IBOutlet UITextField *player4TextField;
@property (weak, nonatomic) IBOutlet UITextField *player5TextField;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

- (id)initWithGameCollection:(GameCollection *)gameCollection;

@end
