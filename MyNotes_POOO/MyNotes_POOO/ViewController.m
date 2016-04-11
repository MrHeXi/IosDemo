//
//  ViewController.m
//  MyNotes_POOO
//
//  Created by 何溪 on 16/4/11.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ViewController.h"
#import "AddNoteViewController.h"
#import "Note.h"
#import "NoteBL.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"备忘录📕";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTable:) name:@"addNewNote" object:nil];
    NoteBL *bl = [[NoteBL alloc] init];
    self.dataList = [bl getAll];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row  = [indexPath row];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    Note* note = [self.dataList objectAtIndex:row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [cell.detailTextLabel setNumberOfLines:2];

    cell.textLabel.text = note.contents;
    cell.detailTextLabel.text = [dateFormatter stringFromDate:note.createTime];

    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
        return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSInteger sourceIndex = sourceIndexPath.row;
    NSInteger destinationIdex = destinationIndexPath.row;
    
    NSString *stringToMove = [self.dataList objectAtIndex:sourceIndex];
    [self.dataList removeObjectAtIndex:sourceIndex];
    [self.dataList insertObject:stringToMove atIndex:destinationIdex];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
        return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray* indexPaths = [NSArray arrayWithObject:indexPath];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataList removeObjectAtIndex: indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [self.tableView reloadData];
}


#pragma mark notification
-(void)reloadTable:(NSNotification*) notification{
    NSMutableArray *data = [notification object];
    self.dataList = data;
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"%@....",segue.identifier);
    if ([segue.identifier isEqualToString:@"ModifyNote"]) {
        AddNoteViewController *addNoteViewController = (AddNoteViewController *)[[segue destinationViewController] topViewController];
       // AddNoteViewController *addNoteViewController = segue.destinationViewController;只能用上面的代码不然会报错
        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow] row];
        Note *note = [self.dataList objectAtIndex:selectedIndex];
        addNoteViewController.title = @"修改我的📕";
        [addNoteViewController setDetailItem:note];
    }
}
@end
