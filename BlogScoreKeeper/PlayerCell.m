#import "PlayerCell.h"

@implementation PlayerCell

- (IBAction)plusButtonTapped:(id)sender {
    [self.delegate playerCellDidTapPlusButton:self];
}

- (IBAction)minusButtonTapped:(id)sender {
    [self.delegate playerCellDidTapMinusButton:self];
}

@end
