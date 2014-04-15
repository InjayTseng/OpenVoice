//
//  MainTabViewController.m
//  OpenVoice
//
//  Created by David Tseng on 2014/4/5.
//  Copyright (c) 2014年 David Tseng. All rights reserved.
//

#import "MainTabViewController.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

-(void)awakeFromNib{

    [self myInit];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self myInit];
    }
    return self;
}

-(void)myInit{
    UIImage* btnimage = [UIImage imageNamed:@"camera_button_take.png"];
    UIImage* highlightimage = [UIImage imageNamed:@"tabBar_cameraButton_ready_matte.png"];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, btnimage.size.width, btnimage.size.height);
    [button setBackgroundImage:btnimage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightimage forState:UIControlStateHighlighted];
    
    //CGFloat heightDifference = btnimage.size.height - self.tabBar.frame.size.height;
    //if (heightDifference < 0)
    button.center = CGPointMake(160, 530);

//    else
//    {
//        CGPoint center = self.tabBar.center;
//        center.y = center.y - heightDifference/2.0;
//        button.center = center;
//    }
    
    [self.view addSubview:button];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"naviback"]
                             forBarMetrics:UIBarMetricsDefaultPrompt];
    //self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@"naviback"];
    self.navigationController.navigationBar.translucent = YES;

    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"openvoice1.png"] forBarMetrics:UIBarMetricsDefaultPrompt];
     
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    /*
    UIImage *image = [UIImage imageNamed: @"openvoice1.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    [imageView setFrame:CGRectMake(0, 0, 150, 44)];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.contentMode = UIViewContentModeTop;
    self.navigationItem.titleView = imageView;
     
     */
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
