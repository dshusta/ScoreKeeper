#import <UIKit/UIKit.h>

@class PlayerCell;


@protocol PlayerCellDelegate <NSObject>

- (void)playerCellDidTapPlusButton:(PlayerCell *)playerCell;
- (void)playerCellDidTapMinusButton:(PlayerCell *)playerCell;

@end


@interface PlayerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *playerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLabel;
@property (weak, nonatomic) IBOutlet UITextField *scoreTextField;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;

@property (weak, nonatomic) id<PlayerCellDelegate> delegate;
@property (nonatomic) NSInteger index;

@end
