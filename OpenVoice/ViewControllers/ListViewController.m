//
//  ListViewController.m
//  OpenVoice
//
//  Created by David Tseng on 2014/3/17.
//  Copyright (c) 2014年 David Tseng. All rights reserved.
//

#import "ListViewController.h"
#import "ELHeaderView.h"
#include "MessageCell.h"
@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) ELHeaderView *headerView;
@property (nonatomic, strong) NSArray* demoContext;

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
//    ELHeaderView *headerView = [[ELHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)backGroudImageURL:@"http://img3.douban.com/view/photo/photo/public/p2162936775.jpg" headerImageURL:@"http://cdn1.techbang.com.tw/system/images/131770/original/7885e4884b1d15c67c04778d1311e5de.png?1377163177" title:@"App Store" subTitle:@"Purchase what you want"];
//    headerView.viewController = self;
//    headerView.scrollView = self.tableView;
//    [self.view addSubview:headerView];
//    _headerView = headerView;
	// Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ELViewControllerCellIdentifier"];
    
    self.demoContext = @[@"小心地滑！",@"老太太需要幫忙",@"這裡有特賣會！",@"有小偷",@"路不平",@"幫買個玉蘭花吧",@"這適合拍照！"];
    
    self.tableView.delegate = self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80.;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.demoContext.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *CellIdentifier = @"MessageCell";
    
    
    MessageCell *cell = (MessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSString *ms = [self.demoContext objectAtIndex:indexPath.row];
    cell.lbTitle.text = ms;
    return cell;
}
- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath{
    
    //Dynamic Color
    int n = indexPath.row+1;
    CGFloat blue_delta = 255/self.demoContext.count;
    
    cell.backgroundColor = [UIColor colorWithRed:(55.)/255. green:(147)/255. blue:(blue_delta)*n/255. alpha:1.];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
