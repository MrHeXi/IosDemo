//
//  ViewController.m
//  AddDeleteCell
//
//  Created by 何溪 on 16/4/7.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"AddOrDeleteCell[添加或删除表格]";
    self.txtField.hidden = YES;
    self.txtField.delegate = self;
    self.itemList =[[NSMutableArray alloc]initWithObjects:@"sqlite",@"mysql",nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UIViewController
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    if (editing) {
        self.txtField.hidden = NO;
    }else{
        self.txtField.hidden = YES;
    }
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.itemList count] + 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIndentifier = @"CellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier forIndexPath:indexPath];
    NSUInteger row = [indexPath row];
    BOOL b_addCell = (row == self.itemList.count);
    if (b_addCell) {
        self.txtField.frame = CGRectMake(10, 0, 300, 44);
        self.txtField.borderStyle = UITextBorderStyleNone;
        self.txtField.placeholder = @"Add cell";
        self.txtField.text = @"";
        [cell.contentView addSubview:self.txtField];
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text =[self.itemList objectAtIndex:row];
    }
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [self.itemList count]) {
        return NO;
    }else{
        return YES;
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSInteger sourceIndex = sourceIndexPath.row;
    NSInteger destinationIdex = destinationIndexPath.row;
    if (destinationIdex == [self.itemList count]) {
        destinationIdex = destinationIdex - 1;
    }
    
    NSString *stringToMove = [self.itemList objectAtIndex:sourceIndex];
    [self.itemList removeObjectAtIndex:sourceIndex];
    [self.itemList insertObject:stringToMove atIndex:destinationIdex];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [self.itemList count]) {
        return UITableViewCellEditingStyleInsert;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray* indexPaths = [NSArray arrayWithObject:indexPath];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.itemList removeObjectAtIndex: indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }else if(editingStyle == UITableViewCellEditingStyleInsert){
        [self.itemList insertObject:self.txtField.text atIndex:[self.itemList count]];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [self.tableView reloadData];
}
#pragma mark --UITableViewDelegate 协议方法

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.itemList count]) {
        return NO;
    } else {
        return YES;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark -- UITextFieldDelegate委托方法,关闭键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

#pragma mark -- UITextFieldDelegate委托方法,避免键盘遮挡文本框
- (void) textFieldDidBeginEditing:(UITextField *)textField {
    UITableViewCell *cell = (UITableViewCell*)textField.superview.superview.superview;
    [self.tableView setContentOffset:CGPointMake(0.0, cell.frame.origin.y) animated:YES];
}

@end
