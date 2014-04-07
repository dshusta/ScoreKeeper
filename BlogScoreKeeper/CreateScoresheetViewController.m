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


    Scoresheet *scoresheet = [[Scoresheet alloc] initWithName:name];
    scoresheet.player1 =  self.player1TextField.text;
    scoresheet.player2 =  self.player2TextField.text;
    scoresheet.player3 =  self.player3TextField.text;
    scoresheet.player4 =  self.player4TextField.text;
    scoresheet.player5 =  self.player5TextField.text;
    
    [self.scoresheetCollection addScoresheet:scoresheet];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
