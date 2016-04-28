//
//  CourseService.h
//  MyLoginDemo
//
//  Created by 何溪 on 16/4/15.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"
#import "Define.h"

@interface CourseService : NSObject
@property(strong,nonatomic) NSMutableArray* dataList;

-(NSMutableArray*) createCourse:(Course*) course;
-(NSMutableArray*) deleteCourse:(Course*) course;
-(NSMutableArray*) modifyCourse:(Course*) course;
-(NSMutableArray*) getAll;
@end
