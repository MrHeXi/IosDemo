//
//  ViewController.h
//  IndexTable
//
//  Created by 何溪 on 16/4/7.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) NSDictionary *dictData;
@property(strong,nonatomic) NSArray *listGroupName;

@end

