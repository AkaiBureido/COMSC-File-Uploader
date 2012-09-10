//
//  COMSC Uploader.m
//  COMSC Batch Uploader
//
//  Created by Oleg Utkin on 9/9/12.
//  Copyright (c) 2012 Oleg Utkin. All rights reserved.
//

#import "COMSC Uploader.h"

@implementation COMSCUploader

@synthesize loginName;
@synthesize password;
@synthesize filesToUpload;

- (id)initWithLoginName:(NSString*)userLoginName withPassword:(NSString*)userPassword
{
    self = [super init];
    if (self) {
        [self setLoginName:userLoginName];
        [self setPassword:userPassword];
    }
    return self;
}

- (void)main {
    NSLog(@"Lets start uploadin'! USNM:%@ PSWD:%@",loginName,password);
    [self uploadFilesFromPathArray:filesToUpload];
}

- (BOOL)uploadFilesFromPathArray:(NSArray*)pathsToUpload {
    BOOL _isSuccessfull = true;
    NSLog(@"This is what we will upload: %@",pathsToUpload);
    
    return _isSuccessfull;
}
@end
