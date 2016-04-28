//
//  CourseCollectionViewController.m
//  MyLoginDemo
//
//  Created by 何溪 on 16/4/14.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "CourseCollectionViewController.h"
#import "CourseCollectionViewCell.h"
#import "CourseDetailController.h"
#import "Define.h"
#import "Course.h"
#import "CourseService.h"
@interface CourseCollectionViewController ()
@property(strong,nonatomic) NSArray *dataList;
@end

@implementation CourseCollectionViewController
{
    CourseService *_courseService;
    
}
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataFile];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    _courseService = [[CourseService alloc]init];
    self.dataList = [_courseService getAll];
    // Do any additional setup after loading the view.
}

-(void)initDataFile{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dbexits = [fileManager fileExistsAtPath:STORE_PATH(COURSE_DATA_FILE)];
    if (!dbexits) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:COURSE_DATA_FILE];
        NSError *error;
        BOOL success = [fileManager copyItemAtPath:defaultDBPath toPath:STORE_PATH(COURSE_DATA_FILE) error:&error];
        NSAssert(success, @"错误写入文件");
        
//        NSString *initIconPaht = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:ICON_FILE_NAME];
//        
//        NSError *error1;
//        BOOL success1 = [fileManager copyItemAtPath:initIconPaht toPath:STORE_PATH(ICON_FILE_NAME) error:&error1];
//        NSAssert(success1, @"错误写入文件");
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return [self.dataList count] /2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CourseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Course *course = [self.dataList objectAtIndex:(indexPath.section*2 +indexPath.row)];
    cell.lable.text = course.name;
    cell.image.image = [UIImage imageNamed:course.courseIcon];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:COURSE_DETAIL]) {
        CourseDetailController *courseDetailController = (CourseDetailController *)[segue destinationViewController];
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems]firstObject];
        NSInteger selectedIndex = (indexPath.section*2 +indexPath.row);
        NSLog(@"%ld",(long)selectedIndex);
        Course *course = [self.dataList objectAtIndex:selectedIndex];
        courseDetailController.title = course.name;
        [courseDetailController setCourse:course];
    }
}
@end
