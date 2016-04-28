//
//  NoteBL.h
//  MyNotes_POOO
//
//  Created by 何溪 on 16/4/11.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "NoteDao.h"
@interface NoteBL : NSObject
-(NSMutableArray*) createNote:(Note*) note;
-(NSMutableArray*) deleteNote:(Note*) note;
-(NSMutableArray*) modifyNote:(Note*) note;
-(NSMutableArray*) getAll;
@end
