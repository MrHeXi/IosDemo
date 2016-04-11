//
//  NoteDao.m
//  MyNotes_POOO
//
//  Created by 何溪 on 16/4/11.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "NoteDao.h"

@implementation NoteDao
static NoteDao* noteDaoInstance = nil;
+(NoteDao*)shareManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date1 = [dateFormatter dateFromString:@"2016-04-10 00:00:00"];
        Note* note1 = [[Note alloc]init];
        note1.createTime = date1;
        note1.contents = @"Welcome te myNotes!";
        note1.noteId = 1;
        
        NSDate *date2 = [dateFormatter dateFromString:@"2016-04-10 12:00:00"];
        Note* note2 = [[Note alloc]init];
        note2.createTime = date2;
        note2.contents = @"欢迎使用我的日记!";
        note2.noteId = 2;
        
        noteDaoInstance = [[self alloc]init];
        noteDaoInstance.dataList = [NSMutableArray arrayWithObjects:note1,note2, nil];

    });
    
    return noteDaoInstance;
}

-(int)createNote:(Note*) note{
    note.noteId = (int)[self.dataList count] + 1;
    [self.dataList addObject:note];
    return 0;
}

-(int)deleteNoteById:(int) noteId{
    for (Note* note in self.dataList) {
        if (noteId == note.noteId) {
            [self.dataList removeObject: note];
            break;
        }
    }
    
    return 0;
}

-(int)remove:(Note*) note{
    for (Note* forNote in self.dataList) {
        if (forNote.noteId == note.noteId && [forNote.createTime isEqualToDate:note.createTime]) {
            [self.dataList removeObject: forNote];
            break;
        }
    }
    
    return 0;
}

-(int)modify:(Note*) note{
    for (Note* forNote in self.dataList) {
        if (forNote.noteId == note.noteId) {
            forNote.contents = note.contents;
            break;
        }
    }
    
    return 0;
}

-(NSMutableArray*)getAll{
    return self.dataList;
}

-(Note*)getNoteById:(int) noteId{
    for (Note* forNote in self.dataList) {
        if (noteId == forNote.noteId) {
            return forNote;
        }
    }
    
    return nil;
}

-(Note*)getNote:(Note*) note{
    for (Note* forNote in self.dataList) {
        if (note.noteId == forNote.noteId &&[note.createTime isEqualToDate:forNote.createTime]) {
            return forNote;
        }
    }
    
    return nil;
}

@end
