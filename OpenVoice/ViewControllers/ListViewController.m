//
//  ListViewController.m
//  OpenVoice
//
//  Created by David Tseng on 2014/3/17.
//  Copyright (c) 2014年 David Tseng. All rights reserved.
//

#import "ListViewController.h"
#import "ELHeaderView.h"
@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) ELHeaderView *headerView;


@end

@implementation ListViewController

-(void)myInit{
    
    self.view.autoresizesSubviews = YES;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|
    UIViewAutoresizingFlexibleWidth|
    UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleTopMargin|
    UIViewAutoresizingFlexibleHeight|
    UIViewAutoresizingFlexibleBottomMargin;
    [self.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height-44)];
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
    ELHeaderView *headerView = [[ELHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)backGroudImageURL:@"http://img3.douban.com/view/photo/photo/public/p2162936775.jpg" headerImageURL:@"http://cdn1.techbang.com.tw/system/images/131770/original/7885e4884b1d15c67c04778d1311e5de.png?1377163177" title:@"App Store" subTitle:@"Purchase what you want"];
    headerView.viewController = self;
    headerView.scrollView = self.tableView;
    [self.view addSubview:headerView];
    _headerView = headerView;
	// Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ELViewControllerCellIdentifier"];
    self.tableView.delegate = self;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ELViewControllerCellIdentifier" forIndexPath:indexPath];
    
    [cell.textLabel setText:@"text Label"];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
