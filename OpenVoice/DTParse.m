//
//  ParseCommon.m
//  ParseCommon
//
//  Created by David Tseng on 11/11/13.
//  Copyright (c) 2013 David Tseng. All rights reserved.
//

#import "DTParse.h"

@implementation DTParse

#pragma mark - Push Notifications

+(NSString*)showSubscribeChannels{

    NSArray *subscribedChannels = [PFInstallation currentInstallation].channels;
    int count = 0;
    NSMutableString * result = [[NSMutableString alloc] init];
    count = subscribedChannels.count;
    for (NSObject * obj in subscribedChannels)
    {
        if ([obj isKindOfClass:[NSNumber class]])
        {
            // append something
        }
        else
        {
            [result appendString:[obj description]];
        }
    }
    NSLog(@"%d Subscribe channels: %@", count,result);
    return [NSString stringWithFormat:@"%@",result];
}

+(void)subscribeChannel:(NSString*)channelName{
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObject:channelName forKey:@"channels"];
    [currentInstallation saveInBackground];
}


+(void)unsubscribeChannel:(NSString*)channelName{

    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation removeObject:channelName forKey:@"channels"];
    [currentInstallation saveInBackground];
}


#pragma mark - User Management

+(void)signUpByName:(NSString*)username andPassword:(NSString*)password andEmail:(NSString*)email
        withSuccess:(XBLOCK)success withFailure:(XERRORBLOCK)failure{
    
    PFUser *user = [PFUser user];
    user.username = username;
    user.password = password;

    //是否為Required.
    if (email) {
        user.email = email;
    }

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            NSLog(@"%@ Signed in.",username);
            success();
        } else {
            NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
            NSLog(@"Error %@",errorString);
            failure(error);
        }
    }];
}

+(void)signUpByName:(NSString*)username andPassword:(NSString*)password
        withSuccess:(XBLOCK)success withFailure:(XERRORBLOCK)failure{

    [self signUpByName:username andPassword:password andEmail:nil withSuccess:^{
       
    } withFailure:^(NSError *err) {
       
    }];

}

+(void)currentUserWithSuccess:(XUSERBLOCK)success withFailure:(XBLOCK)failure{

    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
        NSLog(@"Name %@",currentUser.username);
        success(currentUser);
        
    } else {
        // show the signup or login screen
        NSLog(@"No current User");
        failure();
    }

}

+(void)signUpByName:(NSString*)username andPassword:(NSString*)password{

    PFUser *user = [PFUser user];
    user.username = username;
    user.password = password;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            NSLog(@"%@ Signed in.",username);
        } else {
            NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
            NSLog(@"Error %@",errorString);
        }
    }];
}

+(void)loginByName:(NSString*)username andPassword:(NSString*)password{
    
    [PFUser logInWithUsernameInBackground:username password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            NSLog(@"%@ Login in.",user.username);
                                        } else {
                                            NSString *errorString = [error userInfo][@"error"];
                                            // Show the errorString somewhere and let the user try again.
                                            NSLog(@"Error %@",errorString);
                                        }
                                    }];
}

+(void)currentUser{
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
        NSLog(@"Name %@",currentUser.username);
        
    } else {
        // show the signup or login screen
        NSLog(@"No current User");
    }
}

+(void)logout{
    
    [PFUser logOut];
    
}


#pragma mark - Facebook



+(void)logInWithFacebookByPermissions:(NSArray*)permissions{

    [PFFacebookUtils initializeFacebook];
    [PFFacebookUtils logInWithPermissions:permissions block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
        } else {
            NSLog(@"User logged in through Facebook!");
        }
    }];
    
}


+(void)reauthorizeUserByPermissions:(NSArray*)permissions{
 
    [PFFacebookUtils reauthorizeUser:[PFUser currentUser]
              withPublishPermissions:permissions
                            audience:FBSessionDefaultAudienceFriends
                               block:^(BOOL succeeded, NSError *error) {
                                   if (succeeded) {
                                       // Your app now has publishing permissions for the user
                                   }
                               }];
}


+(void)linkToFacebook:(PFUser*)user{
    
    if (![PFFacebookUtils isLinkedWithUser:user]) {
        [PFFacebookUtils linkUser:user permissions:nil block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Woohoo, %@ logged in with Facebook!",user.username);
            }
        }];
    }
}

+(void)unlinkToFacebook:(PFUser*)user{
    
    [PFFacebookUtils unlinkUserInBackground:user block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"%@ is no longer associated with their Facebook account.",user.username);
        }
    }];
}


+(FBSession*)facebookSession{
    
    return [PFFacebookUtils session];
}



#pragma mark - In-App Purchase


+(void)addObserverForProduct:(NSString*)productName{
    
    // Use the product identifier from iTunes to register a handler.
    [PFPurchase addObserverForProduct:productName block:^(SKPaymentTransaction *transaction) {
        // Write business logic that should run once this product is purchased.
        NSLog(@"adfree is purchased.");
    }];
}

+(void)buyProduct:(NSString*)productName{
    
    [PFPurchase buyProduct:productName block:^(NSError *error) {
        if (!error) {
            // Run UI logic that informs user the product has been purchased, such as displaying an alert view.
             NSLog(@"adfree has purchased.");
        }
    }];
}



+(void)shopByLocation:(CLLocationCoordinate2D)loc andRange:(double)range
          WithSuccess:(XOBJARRAYBLOCK)success withFailure:(XERRORBLOCK)failure{

    //PFGeoPoint *gp = [PFGeoPoint geoPointWithLatitude:loc.latitude longitude:loc.longitude];
    [PFCloud callFunctionInBackground:@"shopByLocation"
                       withParameters:@{@"lat":[NSNumber numberWithDouble:loc.latitude],
                                        @"lng":[NSNumber numberWithDouble:loc.longitude],
                                        @"offset":[NSNumber numberWithDouble:range]
                                        }
                                block:^(NSArray *result, NSError *error) {
                                    if (!error){
                                        success(result);
                                    }else{
                                        failure(error);
                                    }
                                }];
    
}

+(void)getVoiceByLocation:(CLLocationCoordinate2D)loc success:(XOBJARRAYBLOCK)success withFailure:(XERRORBLOCK)failure{
    
    PFGeoPoint *gp = [PFGeoPoint geoPointWithLatitude:loc.latitude longitude:loc.longitude];
    [PFCloud callFunctionInBackground:@"getVoiceByLocation"
                       withParameters:@{@"location":gp}
                                block:^(NSArray *result, NSError *error) {
                                    if (!error){
                                        success(result);
                                    }else{
                                        failure(error);
                                    }
                                }];
    
}

+(void)createVoiceByLocation:(CLLocationCoordinate2D)loc message:(NSString*)message success:(XOBJARRAYBLOCK)success withFailure:(XERRORBLOCK)failure{
    
    PFGeoPoint *gp = [PFGeoPoint geoPointWithLatitude:loc.latitude longitude:loc.longitude];
    [PFCloud callFunctionInBackground:@"createVoice"
                       withParameters:@{@"location":gp,@"message":message}
                                block:^(NSArray *result, NSError *error) {
                                    if (!error){
                                        success(result);
                                    }else{
                                        failure(error);
                                    }
                                }];
    
}



@end
