//
//  User.h
//  MyContacts
//
//  Created by 何溪 on 16/4/12.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(assign,nonatomic)NSNumber * userId;
@property(strong,nonatomic)NSString * userName;
@property(strong,nonatomic)NSString * address;
@property(strong,nonatomic)NSString * tel;
@property(assign,nonatomic)NSNumber * age;
@property(strong,nonatomic)NSString * icon;
@end
