//
//  ViewController.h
//  MyNotes_POOO
//
//  Created by 何溪 on 16/4/11.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) NSMutableArray *dataList;

@end

