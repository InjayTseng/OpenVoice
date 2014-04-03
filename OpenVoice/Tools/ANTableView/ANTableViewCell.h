//
//  ANTableViewCell.h
//  ANBlurredTableViewDemo
//
//  Created by Aaron Ng on 3/10/14.
//  Copyright (c) 2014 Delve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBShimmeringView.h"

@interface ANTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UILabel *moredetailLabel;
@property (strong) CALayer *topBorder;
@property (strong) CALayer *bottomBorder;
@property (strong, nonatomic) FBShimmeringView *shimmeringView;
-(void)showShimmer;
@end
