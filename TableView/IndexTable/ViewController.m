//
//  ViewController.m
//  IndexTable
//
//  Created by 何溪 on 16/4/7.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *dataPath = [bundle pathForResource:@"team_dictionary" ofType:@"plist"];
    NSDictionary *data = [[NSDictionary alloc]initWithContentsOfFile:dataPath];
    self.dictData = data;
    NSArray *tempList = [self.dictData allKeys];
    self.listGroupName = [tempList sortedArrayUsingSelector:@selector(compare:)];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)login:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *groupName = [self.listGroupName objectAtIndex:section];
    NSArray *teamList = [self.dictData objectForKey:groupName];
    return [teamList count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIndentifier = @"CellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier forIndexPath:indexPath];
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    NSString *groupName = [self.listGroupName objectAtIndex:section];
    NSArray *dataList = [self.dictData objectForKey:groupName];
    cell.textLabel.text = [dataList objectAtIndex:row];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.listGroupName count];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *groupName = [self.listGroupName objectAtIndex:section];
    return groupName;
}

-(NSArray *) sectionIndexTitlesForTableView:(UITableView*)tableView{
    NSMutableArray *titleList = [[NSMutableArray alloc]initWithCapacity:[self.listGroupName count]];
   for(NSString *item in self.listGroupName){
       NSString *title = [item substringToIndex:1];
       [titleList addObject: title];
    }

    return titleList;
}
@end
