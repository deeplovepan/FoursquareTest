//
//  FoursquareTestViewController.h
//  FoursquareTest
//
//  Created by Peter Pan on 12/7/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoursquarePlaceTableViewController.h"

@interface FoursquareTestViewController : UIViewController <FoursquarePlaceTableViewControlleDelegate>


- (IBAction)searchPlaceButtonPressed:(id)sender;

@end
