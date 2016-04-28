//
//  CourseDetailController.h
//  MyLoginDemo
//
//  Created by 何溪 on 16/4/15.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

@interface CourseDetailController : UIViewController
-(void)setCourse:(Course *) course;
@property(strong,nonatomic) Course* myCourse;

@end
