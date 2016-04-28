//
//  CourseDetailController.m
//  MyLoginDemo
//
//  Created by 何溪 on 16/4/15.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "CourseDetailController.h"
#import "CourseService.h"
@interface CourseDetailController ()

@property (weak, nonatomic) IBOutlet UITextView *detail;
@property (weak, nonatomic) IBOutlet UIImageView *courseImg;
@end

@implementation CourseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)save:(id)sender {
    NSString *detail = [self.detail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([detail length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请填写姓名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    CourseService *courseService = [[CourseService alloc]init];
    self.myCourse.describe = detail;
    [courseService modifyCourse: self.myCourse];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setCourse:(Course *) course{
    if (_myCourse != course) {
        _myCourse = course;
    }
}

-(void)initData{
    if (self.myCourse !=nil) {
        self.courseImg.image = [UIImage imageNamed:self.myCourse.courseIcon];
        self.detail.text = self.myCourse.describe;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
