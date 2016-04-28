//
//  ContactsTableViewController.m
//  MyLoginDemo
//
//  Created by 何溪 on 16/4/14.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ContactsTableViewController.h"

@interface ContactsTableViewController ()
@property(strong,nonatomic) NSMutableArray *dataList;

@end

@implementation ContactsTableViewController
{
    UserService *_userService;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataFile];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    _userService = [[UserService alloc]init];
    self.dataList = [_userService getAll];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTable:) name:NOTIFY_ADD_USER object:nil];
}

-(void)initDataFile{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dbexits = [fileManager fileExistsAtPath:DATA_PATH];
    NSLog(@"%@",DATA_PATH);
    if (!dbexits) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATA_FILE_NAME];
        NSError *error;
        BOOL success = [fileManager copyItemAtPath:defaultDBPath toPath:DATA_PATH error:&error];
        NSAssert(success, @"错误写入文件");
        
        NSString *initIconPaht = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:ICON_FILE_NAME];

        NSError *error1;
        BOOL success1 = [fileManager copyItemAtPath:initIconPaht toPath:STORE_PATH(ICON_FILE_NAME) error:&error1];
        NSAssert(success1, @"错误写入文件");

    }
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
    return [self.dataList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger row  = [indexPath row];
    ContactsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CELLIDENTIFIER forIndexPath:indexPath];
    User* user = [self.dataList objectAtIndex:row];
    cell.userName.text = user.userName;
    cell.tel.text = user.tel;
    cell.userIcon.image = [UIImage imageWithContentsOfFile:STORE_PATH(user.icon)];
    return cell;
}

-(void)reloadTable:(NSNotification*) notification{
    NSMutableArray *data = [notification object];
    self.dataList = data;
    [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SEGEU_MODIFY_USER]) {
        AddUserViewController *addUserViewController = (AddUserViewController *)[segue destinationViewController];
        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow] row];
        User *user = [self.dataList objectAtIndex:selectedIndex];
        addUserViewController.title = @"修改联系人";
        [addUserViewController setDetailItem:user];
    }
}


@end
