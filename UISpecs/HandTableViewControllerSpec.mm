#import "HandTableViewController.h"
#import "UIBarButtonItem+Spec.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(HandTableViewControllerSpec)

describe(@"HandTableViewController", ^{
    __block HandTableViewController *controller;
    __block UINavigationController *navigationController;

    beforeEach(^{
        controller = [[HandTableViewController alloc] init];
        
        navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        controller.view should_not be_nil;
        [controller.view layoutIfNeeded];
    });
    
    describe(@"tapping New Hand button", ^{
        beforeEach(^{
            [controller.navigationItem.rightBarButtonItem tap];
        });
        
        it(@"should add a new hand", ^{
            [controller.tableView numberOfRowsInSection:0] should equal(1);
            UITableViewCell *cell = [controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.textLabel.text should equal(@"Hand 1");
        });
    });
});

SPEC_END
