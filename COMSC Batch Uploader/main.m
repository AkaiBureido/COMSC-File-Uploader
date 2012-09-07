//
//  main.m
//  COMSC Batch Uploader
//
//  Created by Oleg Utkin on 9/5/12.
//  Copyright (c) 2012 Oleg Utkin. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
            //NSLog(@"Arg num: %i", argc);
            //for (int iterator = 0; iterator < argc ; iterator++) {
            //NSLog(@"Arg [%i]: %s",iterator, argv[iterator]);
            //}
       
        const int testArgc = 1;
        NSString* testArgv[testArgc];
        testArgv[0] = [[NSString alloc] initWithFormat:@"/Users/olegforzane/Desktop/"];
        
        NSFileManager* fileManager = [NSFileManager defaultManager];
        BOOL isDirectory = false;
        BOOL itemExists = [fileManager fileExistsAtPath:testArgv[0] isDirectory:&isDirectory];
        
        if (itemExists == true) {
            NSLog(@"It exists.");
            if (isDirectory == true) {
                NSLog(@"It is a directory.");
                
                    //TODO: scrape all visible files 0 level deep and upload
                
            } else {
                NSLog(@"It is a file.");
                
                    //TODO: upload
            }
        } else {
            NSLog(@"It does not exist.");
        }

    }
    return 0;
}

