#import "CreateGameViewController.h"
#import "GameCollection.h"
#import "Game.h"
#import "Player.h"

@interface CreateGameViewController ()
@property (strong, nonatomic) GameCollection *gameCollection;
@end

@implementation CreateGameViewController

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id)initWithGameCollection:(GameCollection *)gameCollection {
    self = [super initWithNibName:@"CreateGameViewController" bundle:nil];
    if (self) {
        self.gameCollection = gameCollection;
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
    
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.player5TextField.frame),
//                                                                           CGRectGetMaxY(self.player5TextField.frame) + 10,
//                                                                           CGRectGetWidth(self.player5TextField.frame),
//                                                                           CGRectGetHeight(self.player5TextField.frame))];
//    [self.view addSubview:textField];
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

@end
