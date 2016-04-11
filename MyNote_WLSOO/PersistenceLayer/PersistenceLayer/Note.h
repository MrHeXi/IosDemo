//
//  Note.h
//  MyNotes_POOO
//
//  Created by 何溪 on 16/4/11.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property(nonatomic) int noteId;
@property(strong,nonatomic) NSDate* createTime;
@property(strong,nonatomic) NSString* contents;
@end
