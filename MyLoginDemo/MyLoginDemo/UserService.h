//
//  UserService.h
//  MyContacts
//
//  Created by 何溪 on 16/4/12.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface UserService : NSObject
@property(strong,nonatomic) NSMutableArray* dataList;

-(NSMutableArray*) createUser:(User*) user;
-(NSMutableArray*) deleteUser:(User*) user;
-(NSMutableArray*) modifyUser:(User*) user;
-(NSMutableArray*) getAll;
@end
