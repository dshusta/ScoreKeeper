#import "ScoresheetViewController.h"
#import "Scoresheet.h"
#import "Player.h"
#import "PlayerCell.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ScoresheetViewControllerSpec)

describe(@"ScoresheetViewController", ^{
    __block ScoresheetViewController *subject;

    beforeEach(^{
        NSMutableArray *players = [[NSMutableArray alloc]init];
        [players addObject:[[Player alloc] initWithName:@"Michael Jordan"]];
        [players addObject:[[Player alloc] initWithName:@"Scottie Pippen"]];
        [players addObject:[[Player alloc] initWithName:@"Hakeem Olajuwon"]];
        [players addObject:[[Player alloc] initWithName:@"Shaquille O'Neal"]];
        [players addObject:[[Player alloc] initWithName:@"Kobe Bryant"]];
        [players addObject:[[Player alloc] initWithName:@"LeBron James"]];

        Scoresheet *scoresheet = [[Scoresheet alloc] initWithName:@"Special Scoresheet" players:players];
        subject = [[ScoresheetViewController alloc] initWithScoresheet:scoresheet];
        subject.view should_not be_nil;
    });

    it(@"should display the scoresheet name", ^{
        subject.title should equal(@"Special Scoresheet");
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
});

SPEC_END
