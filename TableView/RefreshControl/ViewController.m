//
//  ViewController.m
//  RefreshControl
//
//  Created by 何溪 on 16/4/7.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) NSMutableArray *timeList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeList = [[NSMutableArray alloc]init];
    NSDate *date = [[NSDate alloc]init];
    [self.timeList addObject:date];
    UIRefreshControl *rf =[[UIRefreshControl alloc]init];
    rf.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [rf addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rf;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshTableView{
    if (self.refreshControl.refreshing) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中..."];
        NSDate *date = [[NSDate alloc]init];
        [self.timeList addObject:date];
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
        [self.tableView reloadData];
    }
}
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.timeList count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIndentifier = @"CellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIndentifier];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd HH:mm:ss zzz"];
    cell.textLabel.text = [dateFormatter stringFromDate:[self.timeList objectAtIndex:[indexPath row]]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
@end
