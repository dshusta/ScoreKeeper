#import "ScoresheetViewController.h"
#import "Scoresheet.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ScoresheetViewControllerSpec)

describe(@"ScoresheetViewController", ^{
    __block ScoresheetViewController *subject;

    beforeEach(^{
        Scoresheet *scoresheet = [[Scoresheet alloc] initWithName:@"Special Scoresheet"];
        scoresheet.player1 = @"Michael Jordan";
        scoresheet.player2 = @"Scottie Pippen";
        scoresheet.player3 = @"Hakeem Olajuwon";
        scoresheet.player4 = @"Shaquille O'Neal";
        scoresheet.player5 = @"Kobe Bryant";

        subject = [[ScoresheetViewController alloc] initWithScoresheet:scoresheet];
        subject.view should_not be_nil;
    });

    it(@"should display the proper fields of the scoresheet", ^{
        subject.nameLabel.text should equal(@"Special Scoresheet");
        subject.player1Label.text should equal(@"Michael Jordan");
        subject.player2Label.text should equal(@"Scottie Pippen");
        subject.player3Label.text should equal(@"Hakeem Olajuwon");
        subject.player4Label.text should equal(@"Shaquille O'Neal");
        subject.player5Label.text should equal(@"Kobe Bryant");
    });
});

SPEC_END
