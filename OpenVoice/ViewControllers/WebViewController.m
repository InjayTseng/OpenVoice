//
//  RegistrationViewController.m
//  YouBiker
//
//  Created by injay on 13/6/21.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
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
	// Do any additional setup after loading the view.

    self.wbView.delegate = self;
    [self.wbView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlText]]];
    
}

-(void)viewWillDisappear:(BOOL)animated{

    //[SVProgressHUD dismiss];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{

    //[SVProgressHUD showWithStatus:@"讀取中"];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{

    //[SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
