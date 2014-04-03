//
//  ViewController.m
//  OpenVoice
//
//  Created by David Tseng on 2014/3/17.
//  Copyright (c) 2014年 David Tseng. All rights reserved.
//

#import "ViewController.h"
#import "DAPagesContainer.h"
#import "WebViewController.h"
#import "PersonInfoViewController.h"

@interface ViewController ()
@property (strong, nonatomic) DAPagesContainer *pagesContainer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toWeatherWebPage) name:@"toWeatherWebPage" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNewPage) name:@"PushCenterView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushViewController:) name:@"pushViewController" object:nil];
    
    self.navigationItem.title = @"OpenVoice";
    UIImage *image = [UIImage imageNamed: @"openvoice1.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    [imageView setFrame:CGRectMake(0, 0, 150, 44)];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.contentMode = UIViewContentModeTop;
    self.navigationItem.titleView = imageView;
    
    self.pagesContainer = [[DAPagesContainer alloc] init];
    [self.pagesContainer willMoveToParentViewController:self];
    self.pagesContainer.view.frame = self.view.bounds;
    self.pagesContainer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.pagesContainer.view];
    [self.pagesContainer didMoveToParentViewController:self];
    
    UIViewController *listViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
    listViewController.title = @"時間模式";
    
    UIViewController *mapViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    mapViewController.title = @"地圖模式";
    
    
    UIViewController *anvViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"ANViewController"];
    anvViewController.title = @"附近資訊";
    
    UIViewController *settings =  [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsTableViewController"];
    settings.title = @"設定";
    
    self.pagesContainer.viewControllers = @[settings,anvViewController,mapViewController,listViewController];
    self.pagesContainer.selectedIndex = 1;
    
    [self initRightBarButton];
    
    
}

-(void)initRightBarButton{
    
    UIImage* image3 = [UIImage imageNamed:@"reload_blue.png"];
    CGRect frameimg = CGRectMake(100, 100,30,30);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(reFreshDataFromServer)
              forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem=mailbutton;
}

-(void)pushViewController:(NSNotification*)notif{

    UIViewController* vw = notif.object;

    [self.navigationController pushViewController:vw animated:YES];
    
}

-(void)pushNewPage{

    PersonInfoViewController *pv = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonInfoViewController"];
    [self.navigationController pushViewController:pv animated:YES];
    
    
}


-(void)toWeatherWebPage{
    
    WebViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    [vc setUrlText:@"http://weather.json.tw"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.pagesContainer updateLayoutForNewOrientation:toInterfaceOrientation];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
