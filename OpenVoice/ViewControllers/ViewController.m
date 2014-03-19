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


@interface ViewController ()
@property (strong, nonatomic) DAPagesContainer *pagesContainer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toWeatherWebPage) name:@"toWeatherWebPage" object:nil];
    
    self.navigationItem.title = @"OpenVoice";
    self.pagesContainer = [[DAPagesContainer alloc] init];
    [self.pagesContainer willMoveToParentViewController:self];
    self.pagesContainer.view.frame = self.view.bounds;
    self.pagesContainer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.pagesContainer.view];
    [self.pagesContainer didMoveToParentViewController:self];
    
    UIViewController *listViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
    listViewController.title = @"列表模式";
    
    UIViewController *mapViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    mapViewController.title = @"地圖模式";
    
    self.pagesContainer.viewControllers = @[mapViewController,listViewController];

    
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
