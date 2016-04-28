//
//  CourseService.m
//  MyLoginDemo
//
//  Created by 何溪 on 16/4/15.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "CourseService.h"

@implementation CourseService
-(NSMutableArray*) createCourse:(Course*) course{
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:STORE_PATH(COURSE_DATA_FILE)];
    course.courseId = [NSNumber numberWithShort:[array count]];
    NSDictionary* dict = [NSDictionary
                          dictionaryWithObjects:@[course.courseId,course.name,course.describe,course.courseIcon]
                          forKeys:@[S_COURSE_ID,S_COURSE_NAME,S_COURSE_DESCRIBE,S_COURSE_ICON]];
    
    [array addObject:dict];
    [array writeToFile:STORE_PATH(COURSE_DATA_FILE) atomically:YES];
    
    return [self getAll];
}

-(NSMutableArray*) modifyCourse:(Course*) course{
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:STORE_PATH(COURSE_DATA_FILE)];
    for (NSDictionary* dict in array) {
        NSNumber *courseId = [dict objectForKey:S_COURSE_ID];
        if ([courseId isEqualToNumber:course.courseId]){
            [dict setValue:course.name forKey:S_COURSE_NAME];
            [dict setValue:course.describe forKey:S_COURSE_DESCRIBE];
            [dict setValue:course.courseIcon forKey:S_COURSE_ICON];
            
            [array writeToFile:STORE_PATH(COURSE_DATA_FILE) atomically:YES];
            break;
        }
    }
    
    
    return [self getAll];
    
}

-(NSMutableArray*) deleteCourse:(Course *)course{
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:STORE_PATH(COURSE_DATA_FILE)];
    for (NSDictionary* dict in array) {
        NSNumber *courseId = [dict objectForKey:S_COURSE_ID];
        if ([courseId isEqualToNumber:course.courseId]){
            [array removeObject: dict];
            [array writeToFile:STORE_PATH(COURSE_DATA_FILE) atomically:YES];
            break;
        }
    }
    
    return [self getAll];
}

-(NSMutableArray*) getAll{
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:STORE_PATH(COURSE_DATA_FILE)];
    for (NSDictionary* dict in array) {
        Course *course = [[Course alloc] init];
        course.courseId = [dict objectForKey:S_COURSE_ID];
        course.name = [dict objectForKey:S_COURSE_NAME];
        course.describe = [dict objectForKey:S_COURSE_DESCRIBE];
        course.courseIcon = [dict objectForKey:S_COURSE_ICON];
        [listData addObject:course];
    }
    
    return listData;
}
@end
