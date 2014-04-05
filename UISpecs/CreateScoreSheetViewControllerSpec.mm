#import "CreateScoreSheetViewController.h"
#import "ScoresheetCollection.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(CreateScoreSheetViewControllerSpec)

describe(@"CreateScoreSheetViewController", ^{
    __block CreateScoreSheetViewController *controller;
    __block ScoresheetCollection *collection;

    beforeEach(^{
        collection = [[ScoresheetCollection alloc] init];
        controller = [[CreateScoresheetViewController alloc] initWithScoresheetCollection:collection];
        controller.view should_not be_nil;
    });
    
    describe(@"tapping Save after entering a name", ^{
        beforeEach(^{
//            controller.nameTextField fillWith: blah
        });
        
        
        it(@"should save a scoresheet with the given name", ^{
            
        });
    });
    
    
});

SPEC_END
