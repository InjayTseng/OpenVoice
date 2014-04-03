//
//  OData.m
//  ParseCommon
//
//  Created by David Tseng on 2014/3/14.
//  Copyright (c) 2014年 David Tseng. All rights reserved.
//

#import "OData.h"
#import <CoreLocation/CoreLocation.h>

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject;

@implementation OData

+ (instancetype)sharedManager	{
	DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
		return [[self alloc] init];
	});
}

- (id)init	{
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
        [self.locationManager startUpdatingLocation];
    }
    return self;
}

- (CLLocationCoordinate2D)myLocation {
    return self.locationManager.location.coordinate;
}

+ (NSString*)stringFromTagNumber:(NSString*)tagNumber{


    
    NSDictionary *dic = @{@"1": @"注意",
                          @"2":@"食",
                          @"3":@"住",
                          @"4":@"人",
                          @"5":@"事",
                          @"6":@"好玩",
                          @"7":@"有趣",
                          @"8":@"注意",
                          @"9":@"注意",
                          @"10":@"測試"};
    
    
    
    return dic[tagNumber];
}


@end
