//
//  ANTableViewCell.m
//  ANBlurredTableViewDemo
//
//  Created by Aaron Ng on 3/10/14.
//  Copyright (c) 2014 Delve. All rights reserved.
//

#import "ANTableViewCell.h"
#import "UIView+Borders.h"
#import "FBShimmeringView.h"
#import "HappeningView.h"
@implementation ANTableViewCell

-(void)awakeFromNib{
    self.shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(30, 0, 290, 160)];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.shimmeringView setHidden:YES];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)showShimmer{

    self.shimmeringView.hidden = FALSE;
    self.shimmeringView.shimmering = YES;
    self.shimmeringView.shimmeringBeginFadeDuration = 3.0;
    self.shimmeringView.shimmeringOpacity = 0.5;
    [self.contentView addSubview:_shimmeringView];
    _shimmeringView.contentView = self.label;
}

@end
