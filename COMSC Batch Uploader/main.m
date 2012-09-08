//
//  main.m
//  COMSC Batch Uploader
//
//  Created by Oleg Utkin on 9/5/12.
//  Copyright (c) 2012 Oleg Utkin. All rights reserved.
//

#import <Foundation/Foundation.h>

NSArray* scrapeFiles(NSString *path, NSArray *acceptableExtensions);

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
            //NSLog(@"Arg num: %i", argc);
            //for (int iterator = 0; iterator < argc ; iterator++) {
            //NSLog(@"Arg [%i]: %s",iterator, argv[iterator]);
            //}
       
            //test setup r
        
        const int testArgc = 3;
        NSString* testArgv[testArgc];
        
        testArgv[0] = [[NSString alloc] initWithFormat:@"/Users/olegforzane/Clouds/SkyDrive/Developer_Cloud/College/Comsc210_Workspace/Comsc210_Homework/Lab 2b (Rectangle)/Lab 2b (Rectangle)"];
        testArgv[1] = [[NSString alloc] initWithFormat:@"/Users/olegforzane/Clouds/SkyDrive/Developer_Cloud/College/Comsc210_Workspace/Comsc210_Homework/Lab 3a (Road)/Lab 3a (Road)"];
        testArgv[2] = [[NSString alloc] initWithFormat:@"/Users/olegforzane/Clouds/SkyDrive/Developer_Cloud/College/Comsc210_Workspace/Comsc210_Homework/Lab 2b (Rectangle)/Lab 2b (Rectangle)"];

        
        NSArray *acceptableExtensions = [[NSArray alloc] initWithObjects: @"cpp",
                                                                          @"h", nil];
        
        
        
        NSMutableArray *filesToUpload = [[NSMutableArray alloc] init];
        
        for ( int iterator = 0; iterator < testArgc; iterator++ ) {
            NSArray *currentScrapedFiles;
            @try {
                 currentScrapedFiles = scrapeFiles(testArgv[iterator], acceptableExtensions);
            }
            @catch (NSException *exception) {
                NSLog(@"%@: %@",[exception name], [exception description]);
            }
            NSString* filePath;
            for (filePath in currentScrapedFiles) {
                if (![filesToUpload containsObject:filePath]) {
                    [filesToUpload addObject:filePath];
                }
            }
        }
        
        NSLog(@"%@", filesToUpload);
                
    }
    return 0;
}


NSArray* scrapeFiles(NSString *path, NSArray *acceptableExtensions) {
    NSMutableArray *filesToUpload = [[NSMutableArray alloc] init];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    BOOL isDirectory = false;
    BOOL itemExists = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    
    if (itemExists == true) {
            //NSLog(@"It exists.");
        if (isDirectory == true) {
                //NSLog(@"It is a directory.");
            
            NSDirectoryEnumerator *dir = [fileManager enumeratorAtPath:path];
            
            NSMutableString *filePath;
            while (filePath = [dir nextObject]) {
                if ( [dir level] == 1 ) [dir skipDescendents];
                    
                    //Creating complete filepath:
                filePath = [NSString stringWithFormat:@"%@/%@",path, filePath];
                NSString *fileName = [fileManager displayNameAtPath:filePath];
                
                    //Eliminating hidden files:
                if ([fileName characterAtIndex:0] != '$' && [fileName characterAtIndex:0] != '.') {
                    if (acceptableExtensions == nil) {
                            //Adding all found files
                        [filesToUpload addObject:filePath];
                    } else {
                            //Filtering Files based on extensions
                        if( [acceptableExtensions containsObject:[filePath pathExtension]] ) {
                            [filesToUpload addObject:filePath];
                        }
                    }
                }   
            }
        } else {
                //NSLog(@"It is a file.");
            [filesToUpload addObject:path];
        }
    } else {
            //NSLog(@"It does not exist.");
        [NSException raise:@"NoSuchFile" format:@"File or directory not found"];
    }
    
    return filesToUpload;
}
