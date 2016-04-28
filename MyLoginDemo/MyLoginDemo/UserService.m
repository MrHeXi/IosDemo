//
//  UserService.m
//  MyContacts
//
//  Created by 何溪 on 16/4/12.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "UserService.h"
#import "Define.h"
@implementation UserService
-(NSMutableArray*) createUser:(User*) user{
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:DATA_PATH];
    user.userId = [NSNumber numberWithShort:[array count]];
    NSDictionary* dict = [NSDictionary
                          dictionaryWithObjects:@[user.userId,user.userName,user.age,user.address,user.tel,user.icon]
                          forKeys:@[S_USER_ID,S_USER_NAME,S_AGE,S_ADDRESS,S_TEL,S_ICON]];
    
    [array addObject:dict];
    [array writeToFile:DATA_PATH atomically:YES];
    
    return [self getAll];
}

-(NSMutableArray*) modifyUser:(User*) user{
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:DATA_PATH];
    for (NSDictionary* dict in array) {
        NSNumber *userId = [dict objectForKey:S_USER_ID];
        if ([userId isEqualToNumber:user.userId]){
            [dict setValue:user.userName forKey:S_USER_NAME];
            [dict setValue:user.age forKey:S_AGE];
            [dict setValue:user.address forKey:S_ADDRESS];
            [dict setValue:user.tel forKey:S_TEL];
            [dict setValue:user.icon forKey:S_ICON];

            [array writeToFile:DATA_PATH atomically:YES];
            break;
        }
    }

    
    return [self getAll];
    
}

-(NSMutableArray*) deleteUser:(User *)user{
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:DATA_PATH];
    for (NSDictionary* dict in array) {
        NSNumber *userId = [dict objectForKey:S_USER_ID];
        if ([userId isEqualToNumber:user.userId]){
            [array removeObject: dict];
            [array writeToFile:DATA_PATH atomically:YES];
            break;
        }
    }
    
    return [self getAll];
}

-(NSMutableArray*) getAll{
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:DATA_PATH];
    for (NSDictionary* dict in array) {
        User *user = [[User alloc] init];
        user.userId = [dict objectForKey:S_USER_ID];
        user.userName = [dict objectForKey:S_USER_NAME];
        user.age = [dict objectForKey:S_AGE];
        user.address = [dict objectForKey:S_ADDRESS];
        user.tel = [dict objectForKey:S_TEL];
        user.icon = [dict objectForKey:S_ICON];
        
        [listData addObject:user];
    }
    
    return listData;
}
@end
