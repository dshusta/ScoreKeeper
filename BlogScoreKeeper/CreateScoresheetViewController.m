#import "CreateScoresheetViewController.h"
#import "ScoresheetCollection.h"

@interface CreateScoresheetViewController ()
@property (weak, nonatomic) ScoresheetCollection *scoresheetCollection;
@end

@implementation CreateScoresheetViewController

- (id)initWithScoresheetCollection:(ScoresheetCollection *)scoresheetCollection {
    self = [super initWithNibName:@"CreateScoreSheetViewController" bundle:nil];
    if (self) {
        self.scoresheetCollection = scoresheetCollection;
    }
    return self;
}

- (IBAction)touchUpInsideSaveButton:(id)sender {
    NSMutableDictionary *scoresheet = [[NSMutableDictionary alloc]init];
    scoresheet[@"name"] = self.nameTextField.text;
    [self.scoresheetCollection addObject:scoresheet];

    [self.navigationController popViewControllerAnimated:YES];
}

@end
