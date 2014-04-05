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

- (id)initWithScoresheetCollection:(ScoresheetCollection*) scoresheetCollection {
    self = [self initWithNibName:@"CreateScoreSheetViewController" bundle:nil];
    self.scoresheetCollection = scoresheetCollection;
    return self;
}

- (IBAction)touchUpSaveButton:(id)sender {
    NSString *name = self.nameTextField.text;
    Scoresheet *scoresheet = [[Scoresheet alloc] initWithName:name];
    
    [self.scoresheetCollection addObject:scoresheet];
}

@end
