//
//  ViewController.h
//  OpenVoice
//
//  Created by David Tseng on 2014/3/17.
//  Copyright (c) 2014年 David Tseng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHTabBarController.h"
#define OpenWeatherPage() [[NSNotificationCenter defaultCenter] postNotificationName:@"toWeatherWebPage" object:nil]
#define Push(viewController) [[NSNotificationCenter defaultCenter] postNotificationName:@"pushViewController" object:viewController]
@interface ViewController : UIViewController

@end
