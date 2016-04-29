//
//  MainTableViewController.m
//  UUChartDemo
//
//  Created by 何溪 on 16/4/28.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "MainTableViewController.h"
#import "MyInfoCell.h"
#import "UUChart.h"
#define DEVICE_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define DEVICE_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define Tam_COLOR_HOME_LIME     [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1]
@interface MainTableViewController ()<UUChartDataSource>

@end

@implementation MainTableViewController
{
    UIImageView *_moveImageView;
    UUChart *_chartView;  //图表
    int _controlTag;
    NSArray *_titleLabelArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleLabelArray = [NSArray arrayWithObjects:@"积分",@"学时",@"学分", nil];
    self.tableView.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-100);
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO; //禁用弹簧效果

    self.navigationItem.title=@"UUChart";
    
    for (int i = 0; i<2; i++)
    {
        UIButton *myButton = [[UIButton alloc]init];
        myButton.frame = CGRectMake(40+i*100, self.tableView.frame.size.height-50, 100, 30);
        if (i == 0)
        {
            [myButton setImage:[UIImage imageNamed:@"TamOval_green"] forState:UIControlStateNormal];
            [myButton setTitle:@"自己" forState:UIControlStateNormal];
        }
        else if (i == 1)
        {
            [myButton setImage:[UIImage imageNamed:@"TamOval_red"] forState:UIControlStateNormal];
            [myButton setTitle:@"平均" forState:UIControlStateNormal];
        }
        
        [myButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        myButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.tableView addSubview:myButton];
        UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
        UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
        rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.tableView addGestureRecognizer:rightSwipeGestureRecognizer];
        [self.tableView addGestureRecognizer:leftSwipeGestureRecognizer];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self addChartView];

    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UINib *nib = [UINib nibWithNibName:@"MyInfoCell" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:@"MyInfoCell"];
    // Configure the cell...
    NSInteger row  = [indexPath row];
    MyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyInfoCell" ];
    cell.myImageView.image = [UIImage imageNamed:@"4.jpg"];
    cell.myImageView.layer.masksToBounds = YES; //没这句话它圆不起来
    cell.myImageView.layer.cornerRadius = 75.0/2.0 ; //设置图片圆角的尺度
    cell.userNameLabel.text = @"找大大";
    cell.position.text = @"总统";
    cell.level.text = @"顶级会员";
    return cell;

}
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        _controlTag += 1;
        if (_controlTag >= 3)
        {
            _controlTag = 2;
            return;
        }
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionRight)
    {
        _controlTag -= 1;
        if (_controlTag <= -1)
        {
            _controlTag = 0;
            return;
        }
    }
    [self addChartView];
    [UIView animateWithDuration:0.5 animations:^{
        
        _moveImageView.frame = CGRectMake(20+(DEVICE_WIDTH/3)*_controlTag, 67, DEVICE_WIDTH/3-40, 3);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)addChartView
{
    if (_chartView) {
        [_chartView removeFromSuperview];
        _chartView = nil;
    }
    _chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(10, IS_IPAD?300:170, DEVICE_WIDTH-20,IS_IPAD?DEVICE_HEIGHT-100-240-120: DEVICE_HEIGHT-100-240)
                                               withSource:self
                                                withStyle:UUChartLineStyle];
    [_chartView showInView:self.tableView];
    
}

- (NSArray *)UUChart_xLableArray:(UUChart *)chart{
   NSArray *xTitles = @[@"1",@"2",@"3",@"4",@"5"];
   return xTitles;
}

//数值多重数组
- (NSArray *)UUChart_yValueArray:(UUChart *)chart{
    NSArray *ownCredit;
    NSArray *depCredit;
    if (_controlTag ==0)
    {
        ownCredit = @[@"1",@"2",@"3",@"4",@"5"];
        depCredit = @[@"5",@"4",@"3",@"2",@"1"];
    }
    else if(_controlTag ==1)
    {
        ownCredit = @[@"0.1",@"0.2",@"0.3",@"0.4",@"0.5"];
        depCredit = @[@"0.5",@"0.4",@"0.3",@"0.2",@"0.1"];
    }
    else
    {
        ownCredit = @[@"10",@"20",@"30",@"40",@"50"];
        depCredit = @[@"15",@"25",@"35",@"45",@"55"];
    }
    
    return @[depCredit,ownCredit];
}

- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[UURed,UUGreen];
}

//标记数值区域
- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
{
    //        return CGRangeMake(5, 10);
    return CGRangeZero;
}
//判断显示横线条
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}
//- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
//{
//    return CGRangeMake(100, 0);
//}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return IS_IPAD?150:100;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view1 = [[UIView alloc]init];
    view1.frame = CGRectMake(0, 0, DEVICE_WIDTH, IS_IPAD?140:70);
    view1.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249/255.0 blue:249/255.0 alpha:1];
//    UIView *line1 = [[UIView alloc]init];
//    line1.backgroundColor = Tam_COLOR_HOME_LIME;
//    line1.frame = CGRectMake(0, 1, DEVICE_WIDTH, 0.5);
//    [view1 addSubview:line1];
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = Tam_COLOR_HOME_LIME;
    line2.frame = CGRectMake(0, 69, DEVICE_WIDTH, 0.5);
    [view1 addSubview:line2];
    for (int i=0; i<3; i++)
    {
        UILabel *scoreLabel = [[UILabel alloc]init];
        scoreLabel.frame = CGRectMake((DEVICE_WIDTH/3)*i,  IS_IPAD?84:14,DEVICE_WIDTH/3, 20);
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        scoreLabel.font = [UIFont systemFontOfSize: IS_IPAD?24:16];
        scoreLabel.textColor = [UIColor lightGrayColor];
        switch (i) {
            case 0:
                scoreLabel.text =[NSString stringWithFormat:@"%@",@"不可说"];
                break;
            case 1:
                scoreLabel.text = [NSString stringWithFormat:@"%@",@"不可活"];
                break;
            case 2:
                scoreLabel.text = [NSString stringWithFormat:@"%@",@"不可言"];
                break;
            default:
                break;
        }
        [view1 addSubview:scoreLabel];
        UILabel * title = [[UILabel alloc]init];
        title.text = [_titleLabelArray objectAtIndex:i];
        title.frame = CGRectMake((DEVICE_WIDTH/3)*i, 35,DEVICE_WIDTH/3, 25);
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:IS_IPAD?24:16];
        
        UIControl *myControl = [[UIControl alloc]initWithFrame:CGRectMake((DEVICE_WIDTH/3)*i, 0, DEVICE_WIDTH/3, IS_IPAD?140:70)];
        myControl.tag = i;
        myControl.highlighted = YES;
        [myControl addTarget:self action:@selector(controlBtn:) forControlEvents:UIControlEventTouchUpInside];//todo need to fix 不能点击

        [view1 addSubview:myControl];
        myControl.userInteractionEnabled = YES;
        [view1 addSubview:title];
    }
    _moveImageView = [[UIImageView alloc]init];
    _moveImageView.frame = CGRectMake(20+(DEVICE_WIDTH/3)*_controlTag, 67, DEVICE_WIDTH/3-40, 3);
    _moveImageView.image = [UIImage imageNamed:@"taMoveLine"];
    [view1 addSubview:_moveImageView];
    return view1;
}
-(void)controlBtn:(UIControl *)btn
{
    _controlTag = (int)btn.tag;
    [self addChartView];
    [UIView animateWithDuration:0.5 animations:^{
        _moveImageView.frame = CGRectMake(20+(DEVICE_WIDTH/3)*btn.tag, 67, DEVICE_WIDTH/3-40, 3);
    } completion:^(BOOL finished) {
        
    }];
}
/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
