//
//  BaseViewController.m
//  TaiwenIceCream
//
//  Created by David Tseng on 2/26/14.
//  Copyright (c) 2014 David Tseng. All rights reserved.
//

#import "BaseViewController.h"
#import "JASidePanelController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)awakeFromNib{

    self.leftPanel = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsContainerViewController"];
	self.centerPanel = [self.storyboard instantiateViewControllerWithIdentifier:@"StartNavigationController"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCenter) name:@"showCenter" object:nil];
//    self.navigationItem.title = @"冰淇淋在哪裡";
	// Do any additional setup after loading the view.
}

-(void)showCenter{
    
    [self showCenterPanelAnimated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
