//
//  ViewController.m
//  CollectionView
//
//  Created by 何溪 on 16/4/6.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *dataPath = [bundle pathForResource:@"events" ofType:@"plist"];
    NSArray *dict = [[NSArray alloc]initWithContentsOfFile:dataPath];
    self.events = dict;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.events count] /2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *events = [self.events objectAtIndex:(indexPath.section*2 +indexPath.row)];
    cell.label.text = [events objectForKey:@"name"];
    cell.imageView.image = [UIImage imageNamed:[events objectForKey:@"image"]];
    return cell;
}

#pragma mark UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *events = [self.events objectAtIndex:(indexPath.section*2 +indexPath.row)];
    NSLog(@"select event name:%@",[events objectForKey:@"name"]);
}
@end
