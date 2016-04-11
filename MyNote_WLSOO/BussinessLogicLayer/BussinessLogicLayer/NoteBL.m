//
//  NoteBL.m
//  MyNotes_POOO
//
//  Created by 何溪 on 16/4/11.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "NoteBL.h"
@implementation NoteBL


-(NSMutableArray*) createNote:(Note*) note{
    NoteDao* noteDao = [NoteDao shareManager];
    [noteDao createNote:note];

    return [noteDao getAll];
}
-(NSMutableArray*) deleteNote:(Note*) note{
    NoteDao* noteDao = [NoteDao shareManager];
    [noteDao remove:note];
    
    return [noteDao getAll];
}
-(NSMutableArray*) modifyNote:(Note*) note{
    NoteDao* noteDao = [NoteDao shareManager];
    [noteDao modify:note];
    
    return [noteDao getAll];
}

-(NSMutableArray*) getAll{
    NoteDao* noteDao = [NoteDao shareManager];

    return [noteDao getAll];
}
@end
