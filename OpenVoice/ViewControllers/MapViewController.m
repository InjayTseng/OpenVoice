//
//  MapViewController.m
//  OpenVoice
//
//  Created by David Tseng on 2014/3/17.
//  Copyright (c) 2014年 David Tseng. All rights reserved.
//

#import "ViewController.h"
#import "MapViewController.h"
#import "ExpandableNavigation.h"
#import "WebViewController.h"
#define DEFAULT_LAT 25.032609
#define DEFAULT_LON 121.558727
#define TAG_LBTEXT 111

@interface MapViewController ()<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *btnMore;
@property (strong, nonatomic) IBOutlet UIButton *btnOne;
@property (strong, nonatomic) IBOutlet UIButton *btnTwo;
@property (strong, nonatomic) IBOutlet UIButton *btnThree;
@property (strong, nonatomic) IBOutlet UIButton *btnNavigation;
@property (strong, nonatomic) IBOutlet UIButton *btnWeatherOne;
@property (strong, nonatomic) IBOutlet UIButton *btnWeatherTwo;

@end

@implementation MapViewController{

    ExpandableNavigation* navigation;
}

-(void)myInit{
    
    self.view.autoresizesSubviews = YES;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|
    UIViewAutoresizingFlexibleWidth|
    UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleTopMargin|
    UIViewAutoresizingFlexibleHeight|
    UIViewAutoresizingFlexibleBottomMargin;
    [self.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height)];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self myInit];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setDelegate:self];
    NSArray* buttons = [NSArray arrayWithObjects:self.btnOne,self.btnTwo,self.btnThree, nil];
    for (UIButton *btn in buttons){
        [self setbuttonShadow:btn];
    }
    
    [self setbuttonShadow:self.btnNavigation];
    [self setbuttonShadow:self.btnWeatherOne];
    [self setbuttonShadow:self.btnWeatherTwo];
    
    navigation = [[ExpandableNavigation alloc] initWithMenuItems:buttons mainButton:self.btnMore radius:60.];
    
    [DTParse shopByLocation:[[OData sharedManager] myLocation] andRange:1. WithSuccess:^(NSArray *objectArray) {
       
        //[self setPinsWithArray:objectArray];
        [self setPinsForDemo];
        [self zoomAtMyLocation];
        
    } withFailure:^(NSError *err) {
       
    }];
    // Do any additional setup after loading the view.
}


-(IBAction)toWeatherWebPage{

    OpenWeatherPage();
    
}


-(void)setPinsForDemo{

    NSArray* contextArray = @[@"小心地滑！",@"老太太需要幫忙",@"這裡有特賣會！",@"有小偷",@"路不平",@"幫買個玉蘭花吧",@"這適合拍照！"];
    CLLocationCoordinate2D current = [[OData sharedManager] myLocation];
    for (NSString* str in contextArray){
        
        double x = 0.003 * (double)((double)(arc4random()%10)-5.);
        double y = 0.001 * (double)((double)(arc4random()%10)-5.);
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(current.latitude + x , current.longitude + y );
        NSLog(@"%f,%f",current.latitude + x,current.longitude + y);
        point.coordinate = loc;
        point.title = str;
        point.subtitle = str;
        [self.mapView addAnnotation:point];
        
    }
}

-(void)setPinsWithArray:(NSArray*)array{

    for (PFObject* place in array){
        
        PFGeoPoint* gp = [place objectForKey:@"location"];
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(gp.latitude, gp.longitude);
        point.coordinate = loc;
        point.title = place[@"type"];;
        point.subtitle = place[@"name"];
        [self.mapView addAnnotation:point];
    }
}

-(IBAction)zoomAtMyLocation{

    MKCoordinateRegion region;
    region.center = [[OData sharedManager] myLocation];
    region.span.latitudeDelta = 0.01;
    region.span.longitudeDelta = 0.01;
    [self.mapView setRegion:region animated:YES];

}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    if (annotation == mapView.userLocation) {
        return nil;
    }
    
    static NSString *viewId = @"MKPinAnnotationView";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)
    [self.mapView dequeueReusableAnnotationViewWithIdentifier:viewId];
    UILabel * lbNumber;
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc]
                          initWithAnnotation:annotation reuseIdentifier:viewId];
        lbNumber = [[UILabel alloc]initWithFrame:CGRectMake(-30,-40, 100, 30)];
        [lbNumber setAlpha:0.9];
        //[lbNumber setTextColor:[UIColor colorWithRed:79./255. green:154./255. blue:234./255. alpha:1.]];
        [lbNumber setTextColor:[UIColor darkGrayColor]];
        [lbNumber setBackgroundColor:[UIColor whiteColor]];
        [lbNumber setFont:[UIFont boldSystemFontOfSize:14]];
        [lbNumber setTag:TAG_LBTEXT];
        lbNumber.shadowColor = [UIColor whiteColor];
        lbNumber.shadowOffset = CGSizeMake(-1.0, -3.0);
        lbNumber.layer.cornerRadius = 5.0f;
        lbNumber.layer.masksToBounds = NO;
        lbNumber.layer.borderWidth = 0.0f;
        [lbNumber setTextAlignment:NSTextAlignmentCenter];
        [annotationView addSubview:lbNumber];
    }
    
    lbNumber = (UILabel*)[annotationView viewWithTag:TAG_LBTEXT];
    NSString* show  = [annotation subtitle];
    //PFObject* place = [self getPlaceByName:show];
    [lbNumber setText:show];
    
    UIButton*myButton =[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    myButton.frame =CGRectMake(0,0,40,40);
    [myButton addTarget:self action:@selector(annotaionViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    [myButton setRestorationIdentifier:[annotation title]];
    annotationView.rightCalloutAccessoryView = myButton;
    annotationView.canShowCallout = YES;
    
    return annotationView;
    
}

-(void)annotaionViewClicked:(id)sender{

}

//-(PFObject*)getPlaceByName:(NSString*)name{
//    
//    for (PFObject* obj in self.nearbyShops){
//        if ([name isEqualToString:obj[@"name"]]) {
//            return obj;
//        }
//    }
//    return nil;
//}


-(void)setbuttonShadow:(UIButton*)btn{
    
    //    btn.backgroundColor = [[DataManager shareInstance] favoriteColor];
    btn.layer.cornerRadius = 5.0f;
    btn.layer.masksToBounds = NO;
    btn.layer.borderWidth = 0.0f;
    btn.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    btn.layer.shadowOpacity = 0.4;
    btn.layer.shadowRadius = 5;
    btn.layer.shadowOffset = CGSizeMake(8.0f, 8.0f);
}

-(void)setLabelShadow:(UILabel*)lb{
    lb.layer.cornerRadius = 5.0f;
    lb.layer.masksToBounds = NO;
    lb.layer.borderWidth = 0.0f;
    lb.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    lb.layer.shadowOpacity = 0.4;
    lb.layer.shadowRadius = 5;
    lb.layer.shadowOffset = CGSizeMake(8.0f, 8.0f);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
