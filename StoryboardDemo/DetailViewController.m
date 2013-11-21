//
//  DetailViewController.m
//  StoryboardDemo
//
//  Created by Mox Soini on 9.8.2012.
//  Copyright (c) 2012 Mox Soini. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic) CLLocationCoordinate2D coord;

@property (weak, nonatomic) IBOutlet MKMapView *map;

@end


@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateContents:) name:@"updateMap" object:nil];
}

- (void)updateContents:(NSNotification *)notification
{
    NSDictionary *contents = (NSDictionary *)[notification userInfo];
    [self updateDetails:contents];
}

- (void)updateDetails:(NSDictionary *)contents
{
    if (contents) {
        NSDate *date = [contents objectForKey:@"text"];
        self.title = [date description];
        
        NSArray *c = [contents objectForKey:@"location"];
        CLLocationDegrees lat = [[c objectAtIndex:0] doubleValue];
        CLLocationDegrees lon = [[c objectAtIndex:1] doubleValue];
        
        NSLog(@"Updating coordinates to %.2f %.2f", lat, lon);
        _coord = CLLocationCoordinate2DMake(lat, lon);
        
        if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone) {
            //iPhone with seque
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateMap) userInfo:nil repeats:NO];
        } else {
            [self updateMap];
        }

    }
}

- (void) updateMap
{
    MKMapCamera *camera = _map.camera;
    camera.altitude = 50000; // distance 50 km
    [_map setCamera:camera animated:YES];
    
    [_map setCenterCoordinate:_coord animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
