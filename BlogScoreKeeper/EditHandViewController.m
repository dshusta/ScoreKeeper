#import "EditHandViewController.h"
#import "Game.h"
#import "Hand.h"
#import "GameCollection.h"

@interface EditHandViewController ()
@property (nonatomic, strong) Game *game;
@property(nonatomic, strong) GameCollection *gameCollection;

@end

@implementation EditHandViewController

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id)initWithGameCollection:(GameCollection *)gameCollection game:(Game *)game {
    self = [super initWithNibName:@"EditHandViewController" bundle:nil];
    if (self) {
        self.gameCollection = gameCollection;
        self.game = game;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveHandOnTap:)];
    
    self.player1Label.text = [self.game.players[0] name];
    self.player2Label.text = [self.game.players[1] name];
    self.player3Label.text = [self.game.players[2] name];
    self.player4Label.text = [self.game.players[3] name];
    self.player5Label.text = [self.game.players[4] name];
}

- (void)saveHandOnTap:(id) sender {
    [self.game.hands addObject:[[Hand alloc] init]];
    [self.gameCollection synchronize];
    
    [self.navigationController popViewControllerAnimated:true];
}


@end
