#import "CreateGameViewController.h"
#import "GameCollection.h"
#import "Game.h"
#import "Player.h"

@interface CreateGameViewController ()
@property (strong, nonatomic) GameCollection *gameCollection;
@end

@implementation CreateGameViewController

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
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    
    self.nameTextField.text = [dateFormatter stringFromDate:today];
}

- (IBAction)touchUpSaveButton:(id)sender {
    NSString *name = self.nameTextField.text;

    Player *player1 = [[Player alloc] initWithName:self.player1TextField.text];
    Player *player2 = [[Player alloc] initWithName:self.player2TextField.text];
    Player *player3 = [[Player alloc] initWithName:self.player3TextField.text];
    Player *player4 = [[Player alloc] initWithName:self.player4TextField.text];
    Player *player5 = [[Player alloc] initWithName:self.player5TextField.text];

    NSArray *players = @[player1, player2, player3, player4, player5];
    Game *game = [[Game alloc] initWithName:name
                                    players:players];

    [self.gameCollection addGame:game];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
