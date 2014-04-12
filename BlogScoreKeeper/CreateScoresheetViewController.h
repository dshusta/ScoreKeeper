#import <UIKit/UIKit.h>

@class ScoresheetCollection;

@interface CreateScoresheetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *saveScoresheetButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

-(id)initWithScoresheetCollection:(ScoresheetCollection *)scoresheetCollection;
- (IBAction)touchUpInsideSaveButton:(id)sender;

@end
