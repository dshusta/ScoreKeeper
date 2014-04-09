//
//  CreateScoreSheetViewController.m
//  BlogScoreKeeper
//
//  Created by pivotal on 4/3/14.
//  Copyright (c) 2014 PivotalBeach. All rights reserved.
//

#import "CreateScoresheetViewController.h"
#import "ScoresheetCollection.h"
#import "Scoresheet.h"
#import "Player.h"

@interface CreateScoresheetViewController ()
@property (strong, nonatomic) ScoresheetCollection *scoresheetCollection;
@end

@implementation CreateScoresheetViewController

- (id)initWithScoresheetCollection:(ScoresheetCollection *)scoresheetCollection {
    self = [super init];
    if (self) {
        self.scoresheetCollection = scoresheetCollection;
    }
    return self;
}

- (IBAction)touchUpSaveButton:(id)sender {
    NSString *name = self.nameTextField.text;

    Player *player1 = [[Player alloc] initWithName:self.player1TextField.text];
    Player *player2 = [[Player alloc] initWithName:self.player2TextField.text];
    Player *player3 = [[Player alloc] initWithName:self.player3TextField.text];
    Player *player4 = [[Player alloc] initWithName:self.player4TextField.text];
    Player *player5 = [[Player alloc] initWithName:self.player5TextField.text];

    NSArray *players = @[player1, player2, player3, player4, player5];
    Scoresheet *scoresheet = [[Scoresheet alloc] initWithName:name
                                                      players:players];
    
    [self.scoresheetCollection addScoresheet:scoresheet];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
