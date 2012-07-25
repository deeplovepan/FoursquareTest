//
//  MyFoursquare.h
//  IceCream
//
//  Created by  on 11/12/18.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MyFoursquare : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

+(void)getNearbyPlaceByCoordinate:(CLLocationCoordinate2D)coordinate completionHandler:(void (^)(NSArray *retArray, NSError *retError))handler;
+(void)searchPlaceByName:(NSString*)name coordinate:(CLLocationCoordinate2D)coordinate completionHandler:(void (^)(NSArray *retArray, NSError *retError))handler;

@end
