//
//  ViewController.m
//  ComplexNavigation
//
//  Created by 何溪 on 16/4/7.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *dataPath = [bundle pathForResource:@"provinces_cities" ofType:@"plist"];
    self.dictData = [[NSDictionary alloc]initWithContentsOfFile:dataPath];
    UINavigationController *navigationController = (UINavigationController*)self.parentViewController;
    NSString *selectedProvinces = navigationController.tabBarItem.title;
    NSLog(@"%@",selectedProvinces);
    NSString *key = [[NSString alloc]initWithFormat:@"%@省",selectedProvinces];
    self.dataList = [self.dictData objectForKey:key];
    self.navigationItem.title = [[NSString alloc]initWithFormat:@"%@省信息",selectedProvinces];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }

    UITableViewCell *cell  = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSInteger row = [indexPath row];
    NSDictionary *nameAndUrl = [self.dataList objectAtIndex:row];
    NSString *name = [nameAndUrl objectForKey:@"name"];
    cell.textLabel.text = name;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"%@....",segue.identifier);
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        DetailViewController *detailViewController = segue.destinationViewController;
        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow]row];
        NSDictionary *nameAndUrl = [self.dataList objectAtIndex:selectedIndex];
        detailViewController.url = [nameAndUrl objectForKey:@"url"];
        detailViewController.title = [nameAndUrl objectForKey:@"name"];
    }
}
@end
