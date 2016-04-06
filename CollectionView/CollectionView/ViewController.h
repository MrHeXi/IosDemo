//
//  ViewController.h
//  CollectionView
//
//  Created by 何溪 on 16/4/6.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UICollectionViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic) NSArray *events;

@end

