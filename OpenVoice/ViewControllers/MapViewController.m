//
//  MapViewController.m
//  OpenVoice
//
//  Created by David Tseng on 2014/3/17.
//  Copyright (c) 2014年 David Tseng. All rights reserved.
//

#import "MapViewController.h"
#import "ExpandableNavigation.h"

@interface MapViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *btnMore;
@property (strong, nonatomic) IBOutlet UIButton *btnOne;
@property (strong, nonatomic) IBOutlet UIButton *btnTwo;
@property (strong, nonatomic) IBOutlet UIButton *btnThree;
@property (strong, nonatomic) IBOutlet UIButton *btnNavigation;
@property (strong, nonatomic) IBOutlet UILabel *lbWeatherOne;
@property (strong, nonatomic) IBOutlet UILabel *lbWeatherTwo;

@end

@implementation MapViewController{

    ExpandableNavigation* navigation;
}

-(void)myInit{
    
    self.view.autoresizesSubviews = YES;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|
    UIViewAutoresizingFlexibleWidth|
    UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleTopMargin|
    UIViewAutoresizingFlexibleHeight|
    UIViewAutoresizingFlexibleBottomMargin;
    [self.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height)];
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray* buttons = [NSArray arrayWithObjects:self.btnOne,self.btnTwo,self.btnThree, nil];
    for (UIButton *btn in buttons){
        [self setbuttonShadow:btn];
    }
    [self setbuttonShadow:self.btnNavigation];
    [self setLabelShadow:self.lbWeatherOne];
    [self setLabelShadow:self.lbWeatherTwo];
    navigation = [[ExpandableNavigation alloc] initWithMenuItems:buttons mainButton:self.btnMore radius:60.];
    // Do any additional setup after loading the view.
}

-(void)setbuttonShadow:(UIButton*)btn{
    
    //    btn.backgroundColor = [[DataManager shareInstance] favoriteColor];
    btn.layer.cornerRadius = 5.0f;
    btn.layer.masksToBounds = NO;
    btn.layer.borderWidth = 0.0f;
    btn.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    btn.layer.shadowOpacity = 0.4;
    btn.layer.shadowRadius = 5;
    btn.layer.shadowOffset = CGSizeMake(8.0f, 8.0f);
}

-(void)setLabelShadow:(UILabel*)lb{
    lb.layer.cornerRadius = 5.0f;
    lb.layer.masksToBounds = NO;
    lb.layer.borderWidth = 0.0f;
    lb.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    lb.layer.shadowOpacity = 0.4;
    lb.layer.shadowRadius = 5;
    lb.layer.shadowOffset = CGSizeMake(8.0f, 8.0f);
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
