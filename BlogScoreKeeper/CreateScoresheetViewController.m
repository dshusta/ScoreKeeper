//
//  CreateScoreSheetViewController.m
//  BlogScoreKeeper
//
//  Created by pivotal on 4/3/14.
//  Copyright (c) 2014 PivotalBeach. All rights reserved.
//

#import "CreateScoresheetViewController.h"
#import "ScoresheetCollection.h"

@interface CreateScoresheetViewController ()
@property (weak, nonatomic) ScoresheetCollection *scoresheetCollection;
@end

@implementation CreateScoresheetViewController

- (id)initWithScoresheetCollection:(ScoresheetCollection*) scoresheetCollection {
    self = [super init];
    self.scoresheetCollection = scoresheetCollection;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scoresheetCollection addObject:[[NSDate alloc] init]];
}

@end
