//
//  BaseViewController.h
//  TaiwenIceCream
//
//  Created by David Tseng on 2/26/14.
//  Copyright (c) 2014 David Tseng. All rights reserved.
//

#import "JASidePanelController.h"

#define showCenter() [[NSNotificationCenter defaultCenter]postNotificationName:@"showCenter" object:nil];
#define logout() [[NSNotificationCenter defaultCenter]postNotificationName:@"logout" object:nil];
@interface BaseViewController : JASidePanelController

@end
