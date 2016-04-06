//
//  ViewController.m
//  ActivityIndicatorView_ProgressView
//
//  Created by 何溪 on 16/4/6.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myActivityIndicator;
@property (weak, nonatomic) IBOutlet UIProgressView *myProgress;

@end

@implementation ViewController{
    NSTimer *myTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)activityBtnClick:(id)sender {
    if ([self.myActivityIndicator isAnimating]) {
        [self.myActivityIndicator stopAnimating];
    }else{
        [self.myActivityIndicator startAnimating];
    }
}

- (IBAction)progressBtnClick:(id)sender {
    self.myProgress.progress = 0.0;
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(beginProgress) userInfo:nil repeats:YES];
}

-(void)beginProgress{
    self.myProgress.progress=self.myProgress.progress+0.01;
    if (self.myProgress.progress==1.0) {
        [myTimer invalidate];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"progress complete!" message:@"" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }
}
@end
