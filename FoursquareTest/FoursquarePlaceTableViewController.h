//
//  FoursquarePlaceTableViewController.h
//  Locomote
//
//  Created by Peter Pan on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class MyActivityIndicatorViewLib;
@class MyFoursquare;

@protocol FoursquarePlaceTableViewControlleDelegate <NSObject>

-(void)getPlaceDone:(MyFoursquare*)place;

@end

@interface FoursquarePlaceTableViewController : UIViewController < UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate,
        CLLocationManagerDelegate, UISearchBarDelegate>
{
    NSArray *placeArray;
    NSArray *searchPlaceArray;
    UISearchDisplayController *searchController;
    NSMutableArray *filteredArray;
    UITableView *placeTableView; 
    BOOL isGetCurrentLocation;
    MyActivityIndicatorViewLib *myActivityIndicatorViewLib;
    CLLocationManager *locationManager;
    
    UIView *blackView ;
    CLLocationCoordinate2D currentCoordinate;
}

@property (weak, nonatomic) id <FoursquarePlaceTableViewControlleDelegate> delegate;

@end
