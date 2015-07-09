#import "CreateGameViewController.h"
#import "GameCollection.h"
#import "Game.h"
#import "Player.h"

@interface CreateGameViewController ()
@property (strong, nonatomic) GameCollection *gameCollection;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation CreateGameViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id)initWithGameCollection:(GameCollection *)gameCollection {
    self = [super initWithNibName:@"CreateGameViewController" bundle:nil];
    if (self) {
        self.gameCollection = gameCollection;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"New Game";
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMMM yyyy '-' HH:mm"];
    
    self.nameTextField.text = [dateFormatter stringFromDate:today];

    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;

    self.automaticallyAdjustsScrollViewInsets = NO;

    CGFloat topInset = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    UIEdgeInsets insets = UIEdgeInsetsMake(topInset, 0, 0, 0);
    self.scrollView.contentInset = insets;
    self.scrollView.scrollIndicatorInsets = insets;

    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetMaxY(self.saveButton.frame) + 10;
    self.scrollView.contentSize = CGSizeMake(width, height);
}

- (IBAction)touchUpSaveButton:(id)sender {
    NSString *name = self.nameTextField.text;
    
    __block NSMutableArray *players = [[NSMutableArray alloc] init];
    [self.playerNameFields enumerateObjectsUsingBlock:^(UITextField *playerNameField, NSUInteger index, BOOL *stop) {
        NSString *playerName = [playerNameField text];
        if ([playerName isEqualToString:@""]) {
            playerName = [NSString stringWithFormat:@"Player %li", (long)(index + 1)];
        }
        [players addObject:[[Player alloc] initWithName:playerName]];
    }];
    
    Game *game = [[Game alloc] initWithName:name players:players];

    [self.gameCollection addGame:game];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSValue *frameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [frameValue CGRectValue];

    CGFloat topInset = self.scrollView.contentInset.top;
    UIEdgeInsets insets = UIEdgeInsetsMake(topInset, 0, keyboardFrame.size.height, 0);
    self.scrollView.contentInset = insets;
    self.scrollView.scrollIndicatorInsets = insets;
}

-(void)keyboardDidHide:(NSNotification *)notification {
    CGFloat topInset = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    UIEdgeInsets insets = UIEdgeInsetsMake(topInset, 0, 0, 0);
    self.scrollView.contentInset = insets;
    self.scrollView.scrollIndicatorInsets = insets;
}

@end
