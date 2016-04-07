//
//  ViewController.m
//  TableView
//
//  Created by 何溪 on 16/4/6.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSUInteger)scope;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *dataPath = [bundle pathForResource:@"team" ofType:@"plist"];
    NSArray *data = [[NSArray alloc]initWithContentsOfFile:dataPath];
    self.teamList = data;
    // Do any additional setup after loading the view, typically from a nib.
    
    self.searchBar.delegate = self;
    self.searchBar.showsScopeBar = NO;
    [self.searchBar sizeToFit];
    [self filterContentForSearchText:@""scope:-1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSUInteger)scope{
    if ([searchText length] == 0) {
        self.filterTeamList = [NSMutableArray arrayWithArray:self.teamList];
        return;
    }
    
    NSPredicate *scopePredicate;
    NSArray *tempArray;
    switch (scope) {
        case 0:
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.image contains[c] %@",searchText];
            tempArray = [self.teamList filteredArrayUsingPredicate:scopePredicate];
            self.filterTeamList = [NSMutableArray arrayWithArray:tempArray];
            break;
        case 1:
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
            tempArray = [self.teamList filteredArrayUsingPredicate:scopePredicate];
            self.filterTeamList = [NSMutableArray arrayWithArray:tempArray];
            break;
        default:
            self.filterTeamList = [NSMutableArray arrayWithArray:self.teamList];
            break;
    }
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.filterTeamList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIndentifier = @"CellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier forIndexPath:indexPath];
    NSUInteger row = [indexPath row];
    NSDictionary *team = [self.filterTeamList objectAtIndex:row];
    cell.textLabel.text = [team objectForKey:@"name"];
    NSString *imagePath = [team objectForKey:@"image"];
    imagePath = [imagePath stringByAppendingString:@".png"];
    UIImage *image = [UIImage imageNamed:imagePath];
    cell.imageView.image = image;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark UISearchBarDelegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    self.searchBar.showsScopeBar=TRUE;
    [self.searchBar sizeToFit];
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.searchBar.showsScopeBar = NO;
    [self.searchBar sizeToFit];
    [self.searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self filterContentForSearchText:@"" scope:-1];
    self.searchBar.showsScopeBar = NO;
    [self.searchBar sizeToFit];
    [self.searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self filterContentForSearchText:searchText scope:self.searchBar.selectedScopeButtonIndex];
    [self.tableView reloadData];
}

-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    [self filterContentForSearchText:self.searchBar.text scope:selectedScope];
    [self.tableView reloadData];
}

- (IBAction)login:(id)sender {
}
@end
