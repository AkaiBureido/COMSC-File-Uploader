//
//  main.m
//  COMSC Batch Uploader
//
//  Created by Oleg Utkin on 9/5/12.
//  Copyright (c) 2012 Oleg Utkin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "COMSC Uploader.h"

NSArray* scrapeFiles(NSString *path, NSArray *acceptableExtensions);
NSArray* scrapeFilesFromMultipleLocations(NSArray *locations, NSArray *acceptableExtensions);

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
            //Determine locations
        NSArray* locations = [[NSArray alloc] initWithObjects:
         @"/Users/olegforzane/Clouds/SkyDrive/Developer_Cloud/College/Comsc210_Workspace/Comsc210_Homework/Lab 2b (Rectangle)/Lab 2b (Rectangle)",
         @"/Users/olegforzane/Clouds/SkyDrive/Developer_Cloud/College/Comsc210_Workspace/Comsc210_Homework/Lab 3a (Road)/Lab 3a (Road)",
         @"/Users/olegforzane/Clouds/SkyDrive/Developer_Cloud/College/Comsc210_Workspace/Comsc210_Homework/Lab 2b (Rectangle)/Lab 2b (Rectangle)",
         nil];
        
        NSArray *acceptableExtensions = [[NSArray alloc] initWithObjects: @"cpp", @"h", nil];
        
            //Gather
        NSMutableArray *filesToUpload = [[NSMutableArray alloc] init];
        [filesToUpload addObjectsFromArray: scrapeFilesFromMultipleLocations(locations, acceptableExtensions)];
        
        
            //Upload
        COMSCUploader *uploader = [COMSCUploader alloc];
        
        [uploader initWithLoginName: @"sampleLogin"
                       withPassword :@"samplePassword"];
        
        [uploader setFilesToUpload:filesToUpload];
        
        [uploader start];
        
    }
    return 0;
}

NSArray* scrapeFilesFromMultipleLocations(NSArray *locations, NSArray *acceptableExtensions) {
    NSMutableArray *filesToUpload = [[NSMutableArray alloc] init];
    
    NSString *currentLocation;
    for ( currentLocation in locations ) {
        NSArray *currentScrapedFiles;
        @try {
            currentScrapedFiles = scrapeFiles(currentLocation, acceptableExtensions);
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
    return filesToUpload;
}

    ///If 'acceptableExtensions' is equal to nil then accepting all extensions
NSArray* scrapeFiles(NSString *path, NSArray *acceptableExtensions) {
    NSMutableArray *filesToUpload = [[NSMutableArray alloc] init];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    BOOL isDirectory = false;
    BOOL itemExists = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    
    if (itemExists == true) {
            //If it is a directory scrape the contents 1 level deep
        if (isDirectory == true) {
            NSDirectoryEnumerator *dir = [fileManager enumeratorAtPath:path];
            
            NSMutableString *filePath;
            while (filePath = [dir nextObject]) {
                if ( [dir level] == 1 ) [dir skipDescendents];
                    
                    //Creating complete filepath:
                filePath = [NSString stringWithFormat:@"%@/%@",path, filePath];
                NSString *fileName = [fileManager displayNameAtPath:filePath];
                
                    //Check if it is a directory (no point uploading then)
                BOOL isSubDirectory;
                [fileManager fileExistsAtPath:filePath isDirectory:&isSubDirectory];
                
                    //Eliminating hidden files:
                if ([fileName characterAtIndex:0] != '$' && [fileName characterAtIndex:0] != '.' && !isSubDirectory) {
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
            [filesToUpload addObject:path];
        }
    } else {
        [NSException raise:@"NoSuchFile" format:@"File or directory not found"];
    }
    
    return filesToUpload;
}
