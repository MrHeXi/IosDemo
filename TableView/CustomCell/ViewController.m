//
//  ViewController.m
//  CustomCell
//
//  Created by 何溪 on 16/4/6.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *dataPath = [bundle pathForResource:@"team1" ofType:@"plist"];
    NSArray *data = [[NSArray alloc]initWithContentsOfFile:dataPath];
    self.teamList = data;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.teamList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIndentifier = @"CustomCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier forIndexPath:indexPath];
    NSUInteger row = [indexPath row];
    NSDictionary *team = [self.teamList objectAtIndex:row];
    cell.myLabel.text = [team objectForKey:@"name"];
    NSString *imagePath = [team objectForKey:@"image"];
    imagePath = [imagePath stringByAppendingString:@".png"];
    UIImage *image = [UIImage imageNamed:imagePath];
    cell.myImageView.image = image;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
@end
