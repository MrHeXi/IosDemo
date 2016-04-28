//
//  Define.h
//  MyContacts
//
//  Created by 何溪 on 16/4/12.
//  Copyright © 2016年 何溪. All rights reserved.
//

#ifndef Define_h
#define Define_h


#endif /* Define_h */
#define DATA_FILE_NAME @"UserList.plist"
#define COURSE_DATA_FILE @"Course.plist"
#define ICON_FILE_NAME @"1.jpg"

#define DATA_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:DATA_FILE_NAME]

#define S_USER_ID @"userId"
#define S_USER_NAME @"userName"
#define S_AGE @"age"
#define S_ADDRESS @"address"
#define S_TEL @"tel"
#define S_ICON @"icon"

#define S_COURSE_ID @"courseId"
#define S_COURSE_ICON @"image"
#define S_COURSE_NAME @"name"
#define S_COURSE_DESCRIBE @"describe"


#define CELLIDENTIFIER @"CellIdentifier"

#define NOTIFY_ADD_USER @"addUser"


#define SEGEU_MODIFY_USER @"ModifyUser"
#define COURSE_DETAIL @"CourseDetail"


#define STORE_PATH(fileName) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:(fileName)]