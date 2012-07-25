//
//  MyFoursquare.m
//  IceCream
//
//  Created by  on 11/12/18.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyFoursquare.h"
#import "MyWeb.h"

#define FOURSQUARE_SECRET @"SCSTRATV2B1UHSJNDZTYFZ4MZ4RBWETRVC01H2DTKSAUBCBE"
#define FOURSQUARE_CLIENT_ID @"PLTEWEBWCWFJFDL0MQKMPS0I3RRF30CF30Y5K3ELSFKEBY4S"

@implementation MyFoursquare

@synthesize name;
@synthesize address;
@synthesize coordinate;


// reference:
// https://developer.foursquare.com/overview/versioning
// if no v parameter, the response will contain errorType deprecated
+(void)getNearbyPlaceByCoordinate:(CLLocationCoordinate2D)coordinate completionHandler:(void (^)(NSArray *retArray, NSError *retError))handler
{
    
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%f,%f&client_secret=%@&client_id=%@&v=30000101", coordinate.latitude, coordinate.longitude,
                     FOURSQUARE_SECRET, FOURSQUARE_CLIENT_ID]; 


    NSURLRequest *req = [MyWeb createRequestWithUrlStr:urlStr method:HTTP_ACTION_GET httpBody:nil isUploadFile:NO isUseLocalCache:NO];
    
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
        NSMutableArray *placeArray = nil;

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        if(error == nil)
        {
            NSArray *venueArray = [[dic objectForKey:@"response"] objectForKey:@"venues"];
            if(venueArray)
            {
                placeArray = [NSMutableArray array];
            }
            for(NSDictionary *dic in venueArray)
            {
                MyFoursquare *locInfo = [[MyFoursquare alloc] init];
                locInfo.name = [dic objectForKey:@"name"];
                locInfo.address = [[dic objectForKey:@"location"] objectForKey:@"address"];
                [placeArray addObject:locInfo];
                
                
            }
            

        

        }
        handler(placeArray, error);

    }];

    
        
}

+(void)searchPlaceByName:(NSString*)name coordinate:(CLLocationCoordinate2D)coordinate completionHandler:(void (^)(NSArray *retArray, NSError *retError))handler
{
    
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%f,%f&query=%@&client_secret=%@&client_id=%@&v=30000101", coordinate.latitude, coordinate.longitude, name,
                        FOURSQUARE_SECRET, FOURSQUARE_CLIENT_ID]; 
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLRequest *req = [MyWeb createRequestWithUrlStr:urlStr method:HTTP_ACTION_GET httpBody:nil isUploadFile:NO isUseLocalCache:NO];
    
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSMutableArray *placeArray = nil;
         
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         
         if(error == nil)
         {
             NSArray *venueArray = [[dic objectForKey:@"response"] objectForKey:@"venues"];
             if(venueArray)
             {
                 placeArray = [NSMutableArray array];
             }
             for(NSDictionary *dic in venueArray)
             {                 
                 MyFoursquare *locInfo = [[MyFoursquare alloc] init];
                 locInfo.name = [dic objectForKey:@"name"];
                 NSDictionary *locationDic = [dic objectForKey:@"location"];
                 locInfo.address = [locationDic objectForKey:@"address"];
                 locInfo.coordinate = CLLocationCoordinate2DMake([[locationDic objectForKey:@"lat"] floatValue],
                                                                 [[locationDic objectForKey:@"lng"] floatValue]);
                    
                 [placeArray addObject:locInfo];
                 
                 
             }
             
             
             
             
         }
         handler(placeArray, error);
         
     }];
    
    
    
}


@end
