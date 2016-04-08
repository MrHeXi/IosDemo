//
//  ViewController.m
//  PageViewNavigation
//
//  Created by 何溪 on 16/4/7.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ViewController.h"
enum DirectionForward{
    ForwardBefore = 1,
    ForWardAfter = 2
};

@interface ViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
{
    int pageIndex;
    int directionForward;
}
@property(strong,nonatomic) UIPageViewController *pageViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    UIStoryboard *mainStoryboard = self.storyboard;
    UIViewController *page1ViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"page1"];
    NSArray *viewControllers = @[page1ViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    [self.view addSubview:self.pageViewController.view];
    pageIndex = 0;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIPageViewControllerDataSource
-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    pageIndex--;
    if (pageIndex<0) {
        pageIndex = 0;
        return nil;
    }
    
    directionForward = ForwardBefore;
    UIStoryboard *mainStoryboard = self.storyboard;
    NSString *pageId = [NSString stringWithFormat:@"page%i",pageIndex + 1];
    UIViewController *bfViewController = [mainStoryboard instantiateViewControllerWithIdentifier:pageId];
    return bfViewController;
}

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    pageIndex++;
    if (pageIndex>2) {
        pageIndex = 2;
        return nil;
    }
    
    directionForward = ForWardAfter;
    UIStoryboard *mainStoryboard = self.storyboard;
    NSString *pageId = [NSString stringWithFormat:@"page%i",pageIndex + 1];
    UIViewController *afViewController = [mainStoryboard instantiateViewControllerWithIdentifier:pageId];
    return afViewController;
}
#pragma mark UIPageViewControllerDelegate
-(UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation{
    self.pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (!completed) {
        if (directionForward == ForwardBefore) {
            pageIndex--;
        }
        if (directionForward == ForWardAfter) {
            pageIndex++;
        }
    }
}
@end
