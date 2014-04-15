//
//  ANViewController.m
//  ANBlurredTableViewDemo
//
//  Created by Aaron Ng on 3/10/14.
//  Copyright (c) 2014 Delve. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ANViewController.h"
#import "ANTableViewCell.h"
#import "UIView+Borders.h"
#import "ViewController.h"
#import "VoiceDetailViewController.h"
#import "SOLMainViewController.h"
#import "SOLWundergroundDownloader.h"
#import "Climacons.h"
#import "FBShimmeringView.h"
#import "HappeningView.h"
@interface ANViewController ()

@property (nonatomic,strong) NSMutableArray* voiceArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation ANViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Hide our statusbar for a prettier look.
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl setTintColor:[UIColor whiteColor]];
    [self.refreshControl addTarget:self action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl]; //把RefreshControl加到TableView中

    

    // Stuff for populating our tableView.
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    // Our default color is clear. We want a nice dark gray.
    [_tableView setBlurTintColor:[UIColor colorWithWhite:0.11 alpha:0.5]];
    
    // We want to animate our background's alpha, so switch this to yes.
    [_tableView setAnimateTintAlpha:YES];
    [_tableView setStartTintAlpha:0.25f];
    [_tableView setEndTintAlpha:0.75f];
    
    // Our background image. After this point, ANBlurredTableView takes over and renders the frames.
    [_tableView setBackgroundImage:[UIImage imageNamed:@"city2.jpg"]];
    
    // Offset our header for ~style~ reasons.
    [_tableView setContentInset:UIEdgeInsetsMake(0.0, 0, 0, 0)];
    
    
    
    
    
    Voice* vc1 = [[Voice alloc] initWithMessage:@"小心地滑" tag:[NSNumber numberWithInt:3] location:CLLocationCoordinate2DMake(25., 121.)];
    Voice* vc2 = [[Voice alloc] initWithMessage:@"老太太需要幫忙" tag:[NSNumber numberWithInt:1] location:CLLocationCoordinate2DMake(25., 121.)];
    Voice* vc3 = [[Voice alloc] initWithMessage:@"這裡有特賣會" tag:[NSNumber numberWithInt:2] location:CLLocationCoordinate2DMake(25., 121.)];
    Voice* vc4 = [[Voice alloc] initWithMessage:@"有小偷~~~!!" tag:[NSNumber numberWithInt:5] location:CLLocationCoordinate2DMake(25., 121.)];
    Voice* vc5 = [[Voice alloc] initWithMessage:@"路不平請小心" tag:[NSNumber numberWithInt:4] location:CLLocationCoordinate2DMake(25., 121.)];
 
    self.voiceArray = [[NSMutableArray alloc]initWithObjects:vc1,vc2,vc3,vc4,vc5,vc1,vc2,vc3,vc4,vc5, nil];
    

}

-(void) refresh{
    
    [self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:2];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setlabelRounded:(UILabel*)lb{
    
    //    btn.backgroundColor = [[DataManager shareInstance] favoriteColor];
    lb.layer.cornerRadius = 5.0f;
    lb.layer.masksToBounds = NO;
    lb.layer.borderWidth = 0.0f;
    lb.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    lb.layer.shadowOpacity = 0.4;
    lb.layer.shadowRadius = 5;
    lb.layer.shadowOffset = CGSizeMake(8.0f, 8.0f);
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        headerView.alpha = 0.0;
        return  headerView;
        
    }else if (section == 1) {
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        headerView.backgroundColor = [UIColor clearColor];
        headerView.alpha = 1.;
        
        UILabel* firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 160, 20)];
        firstLabel.text = @"Voices";
        firstLabel.textAlignment = NSTextAlignmentLeft;
        firstLabel.backgroundColor = [UIColor clearColor];
        firstLabel.textColor = [UIColor whiteColor];
        
        
        UILabel* secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 0, 160, 20)];
        secondLabel.text = @"附近正發生的事...";
        secondLabel.textAlignment = NSTextAlignmentCenter;
        secondLabel.backgroundColor = [UIColor colorWithRed:39./255. green:197/255. blue:103./255. alpha:0.9];
        secondLabel.textColor = [UIColor whiteColor];
        secondLabel.font = [UIFont fontWithName:@"Futura" size:15.];
        secondLabel.layer.masksToBounds = YES;
        secondLabel.layer.borderWidth = 2.0f;
        secondLabel.layer.borderColor = [UIColor colorWithRed:39./255. green:197/255. blue:103./255. alpha:0.9].CGColor;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:secondLabel.bounds
                                                       byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                             cornerRadii:CGSizeMake(9.0, 9.0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = secondLabel.bounds;
        maskLayer.path = maskPath.CGPath;
        secondLabel.layer.mask = maskLayer;
        
        
        [headerView addSubview:secondLabel];
        
        
        return headerView;
    }
    else if (section == 2) {
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        headerView.backgroundColor = [UIColor clearColor];
        headerView.alpha = 1.;
        
        
        UILabel* secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 0, 160, 20)];
        secondLabel.text = @"附近餐廳";
        secondLabel.textAlignment = NSTextAlignmentCenter;
        secondLabel.backgroundColor = [UIColor colorWithRed:39./255. green:197/255. blue:103./255. alpha:0.9];
        secondLabel.textColor = [UIColor whiteColor];
        secondLabel.font = [UIFont fontWithName:@"Futura" size:15.];
        secondLabel.layer.masksToBounds = YES;
        secondLabel.layer.borderWidth = 2.0f;
        secondLabel.layer.borderColor = [UIColor colorWithRed:39./255. green:197/255. blue:103./255. alpha:0.9].CGColor;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:secondLabel.bounds
                                                       byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                             cornerRadii:CGSizeMake(9.0, 9.0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = secondLabel.bounds;
        maskLayer.path = maskPath.CGPath;
        secondLabel.layer.mask = maskLayer;
        //    [headerView addSubview:firstLabel];
        [headerView addSubview:secondLabel];
        
        
        return headerView;
    }
    
    return nil;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//
//    return @"Voices";
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0) {
        if (indexPath.row == 1) {
            return 150.;
        }
        
        return 60.;
    }
    
//    else if (indexPath.row == 3){
    
//        // Background rendering row.
//        return 80.0;
//    }
//    else if (indexPath.row == 5){
//        return 140.0;
//    }
//    else if (indexPath.row == 9){
//        return 80.0;
//    }

    return 120.;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Make sure we have enough rows to demonstrate the blur effect.
    if (section==0) {
        return 2;
    }
    else if(section == 1){
    
        return self.voiceArray.count;
    }
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    // Most if not all of this is poorly formatted styling for the table.
    //
    NSString *identifier;
    ANTableViewCell * cell;
    
    if (indexPath.section == 0){
    
        if (indexPath.row == 0){
            identifier = @"ANTableViewCell";
        }
        else if (indexPath.row == 1)
        {
            identifier = @"ANTableViewCenterBodyCell";
        }
    }else{
     
        identifier = @"ANTableViewTitleCell";
    }
    
    
    cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    float addHeight = cell.detailLabel.frame.size.height + 10;
    
    
    if (indexPath.section==0) {
        if (indexPath.row == 0)
        {
            
            [cell.label setFrame:CGRectMake(30, 10, 290, 50)];
            cell.label.text = [NSString stringWithFormat :@"%@ %@",@"台北市",@"23.2°C"];
            cell.label.textAlignment = NSTextAlignmentLeft;
            cell.label.font = [UIFont fontWithName:@"Futura" size:22.];
            
        }
        else if (indexPath.row == 1){
            // Styling
            //        [cell.label setText:@"附近正在發生的事..."];
            [cell.label setFrame:CGRectMake(0, 0, 290, 160)];
            cell.label.font = [UIFont fontWithName:CLIMACONS_FONT size:150];
            cell.label.backgroundColor = [UIColor clearColor];
            cell.label.textColor = [UIColor whiteColor];
            cell.label.textAlignment = NSTextAlignmentLeft;
            cell.label.text = [NSString stringWithFormat:@"%c", ClimaconFlurriesSun];
            
            //        FBShimmeringView *_shimmeringView;
            //        _shimmeringView.tag = 3;
            //        _shimmeringView = [[FBShimmeringView alloc] initWithFrame:cell.label.frame];
            //        _shimmeringView.shimmering = YES;
            //        _shimmeringView.shimmeringBeginFadeDuration = 0.3;
            //        _shimmeringView.shimmeringOpacity = 0.3;
            //        [cell.contentView addSubview:_shimmeringView];
            //        _shimmeringView.contentView = cell.label;
            
            cell.detailLabel.text = @"這附近正在發生的事...";
            cell.detailLabel.textAlignment = NSTextAlignmentCenter;
            [cell showShimmer];
            
        }
        
    }else{
        Voice* vc = [self.voiceArray objectAtIndex:indexPath.row];
        if (!cell.bottomBorder){
            cell.bottomBorder = [cell createBottomBorderWithHeight:2.0f
                                                             color:[UIColor colorWithWhite:1.0f alpha:0.75f]
                                                        leftOffset:20
                                                       rightOffset:0
                                                   andBottomOffset:addHeight];
            [cell.layer addSublayer:cell.bottomBorder];
        }
        
        // Styling
        [cell.label setText:[OData stringFromTagNumber:[NSString stringWithFormat:@"%@",vc.tag]]];
        [cell.detailLabel setText:vc.message];
        
    }
    


 
//        }
    
    
//    
//    if (indexPath.row == 0)
//    {
//        // Styling
//        [cell.label setText:@"ANBlurredTableView!"];
//    }
//    else if (indexPath.row == 1){
//        // Styling
//        [cell.label setText:@"ANBlurredTableView is a simple and flexible UITableView subclass for blurring and tinting the background image of a UITableView on scroll.\n\n Scroll to see it in action."];
//    }
//    else if (indexPath.row == 2){
//        // Bottom Border
//        if (!cell.bottomBorder){
//            cell.bottomBorder = [cell createBottomBorderWithHeight:1.0f
//                                                             color:[UIColor colorWithWhite:1.0f alpha:0.75f]
//                                                        leftOffset:20
//                                                       rightOffset:0
//                                                   andBottomOffset:0];
//            [cell.layer addSublayer:cell.bottomBorder];
//        }
//        
//        // Styling
//        [cell.label setText:@"小心地滑"];
//    }
//    else if (indexPath.row == 3)
//    {
//        // Styling
//        [cell.label setText:@"Animate between two alphas to simulate darkening or lightening while scrolling."];
//    }
//    else if (indexPath.row == 4)
//    {
//        // Bottom Border
//        if (!cell.bottomBorder){
//            cell.bottomBorder = [cell createBottomBorderWithHeight:1.0f
//                                                             color:[UIColor colorWithWhite:1.0f alpha:0.75f]
//                                                        leftOffset:20
//                                                       rightOffset:0
//                                                   andBottomOffset:0];
//            [cell.layer addSublayer:cell.bottomBorder];
//        }
//        
//        // Styling
//        [cell.label setText:@"老太太需要幫忙"];
//    }
//    else if (indexPath.row == 5)
//    {
//        [cell.label setText:@"All frames are rendered in the background. On slower devices, ANBlurredTableView will animate the blur-in to the user's current contentOffset when rendering has finished."];
//    }
//    else if (indexPath.row == 6)
//    {
//        // Bottom Border
//        if (!cell.bottomBorder){
//            cell.bottomBorder = [cell createBottomBorderWithHeight:1.0f
//                                                             color:[UIColor colorWithWhite:1.0f alpha:0.75f]
//                                                        leftOffset:20
//                                                       rightOffset:0
//                                                   andBottomOffset:0];
//            [cell.layer addSublayer:cell.bottomBorder];
//        }
//        
//        // Styling
//        [cell.label setText:@"這裡有特賣會！"];
//        
//    }
//    else if (indexPath.row == 7)
//    {
//        // Styling
//        [cell.label setText:@"Customize your blur with custom tints, scroll lengths and more!"];
//    }
//    
//    else if (indexPath.row == 8)
//    {
//        // Bottom Border Setup
//        if (!cell.bottomBorder){
//            cell.bottomBorder = [cell createBottomBorderWithHeight:1.0f
//                                                             color:[UIColor colorWithWhite:1.0f alpha:0.75f]
//                                                        leftOffset:20
//                                                       rightOffset:0
//                                                   andBottomOffset:0];
//            [cell.layer addSublayer:cell.bottomBorder];
//        }
//        
//        // Styling
//        [cell.label setText:@"CONTRIBUTE"];
//        
//    }
//    
//    else if (indexPath.row == 9)
//    {
//        //Styling
//        [cell.label setText:@"Help make ANBlurredTableView by contributing! Find me on Github at github.com/aaronn"];
//    }
//    
//    else if (indexPath.row == 10)
//    {
//        // Bottom Border
//        if (!cell.bottomBorder){
//            cell.bottomBorder = [cell createBottomBorderWithHeight:1.0f
//                                                             color:[UIColor colorWithWhite:1.0f alpha:0.75f]
//                                                        leftOffset:20
//                                                       rightOffset:0
//                                                   andBottomOffset:0];
//            [cell.layer addSublayer:cell.bottomBorder];
//        }
//        
//        // Styling
//        [cell.label setText:@"CREDITS"];
//    }
//    
//    else if (indexPath.row == 11)
//    {
//        //Styling
//        [cell.label setText:@"Made by Aaron Ng. Follow me on Twitter at @aaronykng."];
//    }
//    
//    else if (indexPath.row == 12)
//    {
//        // Border
//        if (!cell.bottomBorder){
//            cell.bottomBorder = [cell createBottomBorderWithHeight:1.0f
//                                                             color:[UIColor colorWithWhite:1.0f alpha:0.75f]
//                                                        leftOffset:20
//                                                       rightOffset:0
//                                                   andBottomOffset:0];
//            [cell.layer addSublayer:cell.bottomBorder];
//        }
//        
//        // Styling
//        [cell.label setText:@"FILLER ROWS"];
//        
//    }
//    
//    else if (indexPath.row > 12){
//        //Styling
//        if (cell == nil){
//            [cell.label setTextAlignment:NSTextAlignmentLeft];
//        }
//        [cell.label setText:@"A Dummy Row"];
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    VoiceDetailViewController *vw = [self.storyboard instantiateViewControllerWithIdentifier:@"VoiceDetailViewController"];
    [vw setCurrentVoice:[self.voiceArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:vw
                                         animated:YES];
//    Push(vw);
    NSLog(@"%d",indexPath.row);
}

@end
