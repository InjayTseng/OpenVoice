//
//  Vioce.m
//  OpenVoice
//
//  Created by David Tseng on 2014/4/2.
//  Copyright (c) 2014年 David Tseng. All rights reserved.
//

#import "Voice.h"

@implementation Voice

-(id)initWithPFObject:(id)object{

    self = [super init];
    if (self) {
        PFObject* parseObject = object;
        self.objectID = [parseObject valueForKey:@"objectId"];
        self.tag =[parseObject valueForKey:@"tagNumber"];
        self.message =[parseObject valueForKey:@"message"];
        PFGeoPoint * gp = [object valueForKey:@"location"];
        self.location = CLLocationCoordinate2DMake(gp.latitude,gp.longitude);
    }
    return self;
}

-(id)initWithMessage:(NSString*)message tag:(NSNumber*)tag location:(CLLocationCoordinate2D)location{

    self = [super init];
    if (self) {

        self.tag =tag;
        self.message =message;
        self.location = location;
    }
    return self;
}
@end


