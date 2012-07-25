//
//  FoursquarePlaceTableViewController.m
//  Locomote
//
//  Created by Peter Pan on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FoursquarePlaceTableViewController.h"
#import "MyFoursquare.h"
#import "MyActivityIndicatorViewLib.h"
#import "IosDefaultUi.h"

#define SEARCH_TABLE_ROW_CUSTOM 0
#define SEARCH_TABLE_ROW_SEARCH 1

@interface FoursquarePlaceTableViewController ()

@end

@implementation FoursquarePlaceTableViewController

@synthesize delegate;

-(void)dealloc
{
    [locationManager stopUpdatingLocation];
    locationManager.delegate = nil;
        
}

- (void)filterContentForSearchText:(NSString*)searchText
{
    
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[filteredArray removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
    
       
	for (MyFoursquare *place in placeArray)
	{
        NSRange range = [place.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
        /*
         NSComparisonResult result = [eventName compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
         NSLog(@"%@ %@ %d", eventName, searchText, result);
         if (result == NSOrderedSame)
         {
         [filteredArray addObject:dic];
         }
         */
        if(range.location != NSNotFound)
        {
            [filteredArray addObject:place];
        }
		
	}
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    filteredArray = [[NSMutableArray alloc] init];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    searchBar.delegate = self;
    searchBar.tintColor = [UIColor colorWithRed:248/255.0 green:150/255.0 blue:29/255.0 alpha:1];

    searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchController.searchResultsDataSource = self;
    searchController.searchResultsDelegate = self;
    searchController.delegate = self;

    
    [self.view addSubview:searchBar];
    
    placeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.frame.size.height-44)];

    [self.view addSubview:placeTableView];
    placeTableView.dataSource = self;
    placeTableView.delegate = self;
    
    myActivityIndicatorViewLib = [[MyActivityIndicatorViewLib alloc] init];
    [myActivityIndicatorViewLib showUIActivityIndicatorWithframe:CGRectMake(160-50, placeTableView.frame.size.height/2-50, 100, 100) text:@"Loading" isLockScreen:NO onView:self.view];
    

    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - custom method

-(void)searchPlaceByNameDone:(NSArray*)retArray
{
    [blackView removeFromSuperview];
    blackView = nil;
    searchPlaceArray = retArray;
    searchController.searchResultsTableView.hidden = NO;
    [self.searchDisplayController.searchResultsTableView reloadData];
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    
    if(tableView ==  searchController.searchResultsTableView)
    {
        return searchPlaceArray.count;
    }
    else
    {
        return placeArray.count;

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    
    // Configure the cell...
    NSString *showStr;
    if(tableView ==  searchController.searchResultsTableView)
    {
        MyFoursquare *place = [searchPlaceArray objectAtIndex:indexPath.row];
        showStr = place.name;
    }
    else
    {
        MyFoursquare *place = [placeArray objectAtIndex:indexPath.row];
        showStr = place.name;

    }
    
    cell.textLabel.text = showStr;
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    NSString *placeName;
    MyFoursquare *place;
    
    if(tableView == searchController.searchResultsTableView)
    {
        place = [searchPlaceArray objectAtIndex:indexPath.row];
        
    }
    else
    {
        place = [placeArray objectAtIndex:indexPath.row];
    }

    [self.delegate getPlaceDone:place];
    
    if(self.presentingViewController)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];

    }
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if(isGetCurrentLocation == NO)
    {
        isGetCurrentLocation = YES;
        currentCoordinate = newLocation.coordinate;
        [MyFoursquare getNearbyPlaceByCoordinate:currentCoordinate completionHandler:^(NSArray *retArray, NSError *retError) {
            
            [myActivityIndicatorViewLib removeUIActivityIndicator];
            
            placeArray = retArray;
            [placeTableView reloadData];
        }];

    }
    
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    /*
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]
                               scope:[self.searchDisplayController.searchBar selectedScopeButtonIndex]];
     */
    
    __weak FoursquarePlaceTableViewController *selfController = self;
    [MyFoursquare searchPlaceByName:searchBar.text coordinate:currentCoordinate  completionHandler:^(NSArray *retArray, NSError *retError) {   
        [selfController searchPlaceByNameDone:retArray];
        
       
    }];
    
   
    
}

#pragma mark - UISearchDisplayController Delegate Methods

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    
    blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, placeTableView.frame.size.width,
                                                                 placeTableView.frame.size.height)];
    blackView.backgroundColor = [UIColor blackColor];
    [placeTableView addSubview:blackView];
    
}


- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{

    [blackView removeFromSuperview];
    blackView = nil;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{

    tableView.hidden = YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView
{
    if(blackView == nil)
    {
        blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, placeTableView.frame.size.width,
                                                             placeTableView.frame.size.height)];
        blackView.backgroundColor = [UIColor blackColor];
        [placeTableView addSubview:blackView];

    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    return NO;
}


@end
