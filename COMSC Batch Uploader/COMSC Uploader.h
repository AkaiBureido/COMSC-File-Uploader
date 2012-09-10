//
//  COMSC Uploader.h
//  COMSC Batch Uploader
//
//  Created by Oleg Utkin on 9/9/12.
//  Copyright (c) 2012 Oleg Utkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COMSCUploader : NSOperation {
    NSString *loginName, *password;
    
    NSArray *filesToUpload;
}

@property (copy) NSString *loginName;
@property (copy) NSString *password;
@property (copy) NSArray *filesToUpload;

- (id)initWithLoginName:(NSString*)userLoginName
           withPassword:(NSString*)userPassword;

- (void)main;
- (BOOL)uploadFilesFromPathArray:(NSArray*)pathsToUpload;

@end
