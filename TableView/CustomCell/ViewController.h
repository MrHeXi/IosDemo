//
//  ViewController.h
//  CustomCell
//
//  Created by 何溪 on 16/4/6.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) NSArray *teamList;

- (IBAction)login:(id)sender;

@end

