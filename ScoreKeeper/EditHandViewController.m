#import "EditHandViewController.h"
#import "Game.h"
#import "Hand.h"
#import "GameCollection.h"

@interface EditHandViewController ()
@property (nonatomic, strong) Game *game;
@property (nonatomic, strong) GameCollection *gameCollection;
@property (nonatomic, strong) Hand *currentHand;

@end

@implementation EditHandViewController

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id)initWithGameCollection:(GameCollection *)gameCollection game:(Game *)game hand:(Hand *) hand {
    self = [super initWithNibName:@"EditHandViewController" bundle:nil];
    if (self) {
        self.gameCollection = gameCollection;
        self.game = game;
        self.currentHand = hand;
    }
    return self;
}

- (id)initWithGameCollection:(GameCollection *)gameCollection game:(Game *)game {
    return [self initWithGameCollection:gameCollection game:game hand:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.currentHand) {
        for (UIButton *pickerButton in [self pickerButtons]) {
            pickerButton.enabled = NO;
        }
        
        NSArray *names = [self.game.players valueForKey:@"name"];
        NSUInteger pickerIndex = [names indexOfObject:self.currentHand.pickerName];
        
        UIButton *selectedPickerButton = [self pickerButtons][pickerIndex];
        selectedPickerButton.selected = YES;
    }
    else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveHandOnTap:)];
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    
    self.player1Label.text = [self.game.players[0] name];
    self.player2Label.text = [self.game.players[1] name];
    self.player3Label.text = [self.game.players[2] name];
    self.player4Label.text = [self.game.players[3] name];
    self.player5Label.text = [self.game.players[4] name];
}

- (NSArray *)pickerButtons {
    return @[self.player1PickerButton,
             self.player2PickerButton,
             self.player3PickerButton,
             self.player4PickerButton,
             self.player5PickerButton];
}

- (IBAction)didTapPickerButton:(id)sender {
    for (UIButton *pickerButton in [self pickerButtons]) {
        pickerButton.enabled = NO;
        
        if (pickerButton == sender) {
            pickerButton.selected = YES;
        }
    }
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (NSString*)nameOfPicker {
    __block NSString *pickerName;
    [[self pickerButtons] enumerateObjectsUsingBlock:^(UIButton *pickerButton, NSUInteger i, BOOL *stop) {
        if (pickerButton.selected) {
            pickerName = [self.game.players[i] name];
            *stop = YES;
        }
    }];
    return pickerName;
}

- (void)saveHandOnTap:(id) sender {
    self.currentHand = [[Hand alloc] initWithPickerName:[self nameOfPicker]];
    
    [self.game.hands addObject:self.currentHand];
    
    [self.gameCollection synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
