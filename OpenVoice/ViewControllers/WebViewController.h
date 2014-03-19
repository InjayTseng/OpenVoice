//
//  RegistrationViewController.h
//  YouBiker
//
//  Created by injay on 13/6/21.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *wbView;
@property (strong, nonatomic) NSString *urlText;


@end
