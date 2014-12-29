#import "GameViewController.h"
#import "Game.h"
#import "Player.h"
#import "GameCollection.h"
#import "UIKit+PivotalSpecHelper.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(GameViewControllerSpec)

describe(@"GameViewController", ^{
    __block GameViewController *subject;
    __block GameCollection *gameCollection;

    beforeEach(^{
        NSMutableArray *players = [[NSMutableArray alloc]init];
        [players addObject:[[Player alloc] initWithName:@"Michael Jordan"]];
        [players addObject:[[Player alloc] initWithName:@"Scottie Pippen"]];
        [players addObject:[[Player alloc] initWithName:@"Hakeem Olajuwon"]];
        [players addObject:[[Player alloc] initWithName:@"Shaquille O'Neal"]];
        [players addObject:[[Player alloc] initWithName:@"Kobe Bryant"]];
        [players addObject:[[Player alloc] initWithName:@"LeBron James"]];

        [players[1] setScore:1];
        [players[2] setScore:4];
        [players[3] setScore:12];
        [players[4] setScore:-5];

        gameCollection = nice_fake_for([GameCollection class]);

        Game *game = [[Game alloc] initWithName:@"Special Game" players:players];
        subject = [[GameViewController alloc] initWithGameCollection:gameCollection
                                                                game:game];
        subject.view should_not be_nil;
    });

    it(@"should display the game name", ^{
        subject.title should equal(@"Special Game");
    });

    it(@"should display a row for each player", ^{
        [subject.tableView numberOfRowsInSection:0] should equal(6);

        PlayerCell *cell;

        cell = (id)[subject.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.playerNameLabel.text should equal(@"Michael Jordan");

        cell = (id)[subject.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell.playerNameLabel.text should equal(@"Scottie Pippen");

        cell = (id)[subject.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        cell.playerNameLabel.text  should equal(@"Hakeem Olajuwon");

        cell = (id)[subject.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        cell.playerNameLabel.text should equal(@"Shaquille O'Neal");

        cell = (id)[subject.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        cell.playerNameLabel.text should equal(@"Kobe Bryant");

        cell = (id)[subject.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.playerNameLabel.text should equal(@"LeBron James");
    });

    it(@"should display the players' score", ^{
        [subject.tableView layoutIfNeeded];

        PlayerCell *cell;

        cell = (id)[subject.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.totalScoreLabel.text should equal(@"0");

        cell = (id)[subject.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell.totalScoreLabel.text should equal(@"1");

        cell = (id)[subject.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        cell.totalScoreLabel.text should equal(@"4");

        cell = (id)[subject.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        cell.totalScoreLabel.text should equal(@"12");

        cell = (id)[subject.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        cell.totalScoreLabel.text should equal(@"-5");

        cell = (id)[subject.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.totalScoreLabel.text should equal(@"0");
    });

    describe(@"adding points to a player", ^{
        beforeEach(^{
            [subject.tableView layoutIfNeeded];

            PlayerCell *cell = (id)[subject.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];

            cell.scoreTextField.text = @"3";
            [cell.plusButton tap];
        });

        it(@"should update the cell", ^{
            PlayerCell *cell = (id)[subject.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            cell.totalScoreLabel.text should equal(@"7");
        });

        it(@"should save the game", ^{
            gameCollection should have_received(@selector(saveToUserDefaults));
        });
    });

    describe(@"subtracting points from player", ^{
        beforeEach(^{
            [subject.tableView layoutIfNeeded];

            PlayerCell *cell = (id)[subject.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];

            cell.scoreTextField.text = @"3";
            [cell.minusButton tap];
        });

        it(@"should update total score label", ^{
            PlayerCell *cell = (id)[subject.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            cell.totalScoreLabel.text should equal(@"1");
        });

        it(@"should save the game", ^{
            gameCollection should have_received(@selector(saveToUserDefaults));
        });
    });
});

SPEC_END
