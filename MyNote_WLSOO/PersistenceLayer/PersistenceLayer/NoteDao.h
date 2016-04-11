//
//  NoteDao.h
//  MyNotes_POOO
//
//  Created by 何溪 on 16/4/11.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"

@interface NoteDao : NSObject
@property(strong,nonatomic) NSMutableArray* dataList;

+(NoteDao*)shareManager;

-(int)createNote:(Note*) note;

-(int)deleteNoteById:(int) noteId;

-(int)remove:(Note*) note;

-(int)modify:(Note*) note;

-(NSMutableArray*)getAll;

-(Note*)getNoteById:(int) noteId;

-(Note*)getNote:(Note*) note;

@end
