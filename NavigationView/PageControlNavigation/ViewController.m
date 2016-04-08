//
//  ViewController.m
//  PageControlNavigation
//
//  Created by 何溪 on 16/4/7.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ViewController.h"
#define deviceWidth 375.0f
@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(strong,nonatomic) UIView *page1;
@property(strong,nonatomic) UIView *page2;
@property(strong,nonatomic) UIView *page3;

- (IBAction)changePage:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    self.scrollView.contentSize =CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height);
    self.scrollView.frame = self.view.frame;
    UIStoryboard *mainStoryBoard = self.storyboard;
    UIViewController *page1ViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"page1"];
    self.page1 = page1ViewController.view;
    self.page1.frame = CGRectMake(0.0f, 0.0f, deviceWidth, 420.0f);
    
    
    UIViewController *page2ViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"page2"];
    self.page2 = page2ViewController.view;
    self.page2.frame = CGRectMake(deviceWidth, 0.0f, deviceWidth, 420.0f);
    
    UIViewController *page3ViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"page3"];
    self.page3 = page3ViewController.view;
    self.page3.frame = CGRectMake(2*deviceWidth, 0.0f, deviceWidth, 420.0f);
    
    [self.scrollView addSubview:self.page1];
    
    [self.scrollView addSubview:self.page2];
    
    [self.scrollView addSubview:self.page3];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    self.pageControl.currentPage = offset.x /deviceWidth;
}

- (IBAction)changePage:(id)sender {
    [UIView animateWithDuration:0.3f animations:^{
        NSInteger whichPage = self.pageControl.currentPage;
        self.scrollView.contentOffset = CGPointMake(deviceWidth* whichPage, 0.0f);
    }];
}
@end
