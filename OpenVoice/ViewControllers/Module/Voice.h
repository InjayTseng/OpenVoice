//
//  Vioce.h
//  OpenVoice
//
//  Created by David Tseng on 2014/4/2.
//  Copyright (c) 2014年 David Tseng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Voice : NSObject
@property (nonatomic,strong) NSString* objectID;
@property (nonatomic,strong) NSString* message;
@property (nonatomic,strong) NSNumber* tag;
@property (nonatomic,readwrite) CLLocationCoordinate2D location;
-(id)initWithPFObject:(id)object;
-(id)initWithMessage:(NSString*)message tag:(NSNumber*)tag location:(CLLocationCoordinate2D)location;
@end
