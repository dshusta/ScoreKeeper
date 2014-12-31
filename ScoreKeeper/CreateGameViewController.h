#import <UIKit/UIKit.h>
#import "GameCollection.h"

@interface CreateGameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *playerNameFields;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

- (id)initWithGameCollection:(GameCollection *)gameCollection;

@end
