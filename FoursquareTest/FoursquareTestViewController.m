//
//  FoursquareTestViewController.m
//  FoursquareTest
//
//  Created by Peter Pan on 12/7/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FoursquareTestViewController.h"
#import "MyFoursquare.h"

@interface FoursquareTestViewController ()

@end

@implementation FoursquareTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)searchPlaceButtonPressed:(id)sender {
    
    FoursquarePlaceTableViewController *controller = [[FoursquarePlaceTableViewController alloc] init];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
    
    
}



#pragma mark - FoursquarePlaceTableViewControlleDelegate

-(void)getPlaceDone:(MyFoursquare*)place
{
    
}

@end
