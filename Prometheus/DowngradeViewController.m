//
//  DowngradeViewController.m
//  Prometheus
//
//  Created by Jake James on 7/28/17.
//  Copyright © 2017 Jake James. All rights reserved.
//  Sorry for ugly code mr.nullpixel
//  People who aren't allowed to use, download, modify or distribute this software:
/*
 1. nullpixel aka nullriver aka Jamie Bishop aka Jane Bishop aka nullbrain
 2. 1Conan aka Conan edogavablablah
 3. Blu3Dev aka Blu3_dev aka B******* (I know your secret :p xd :d ;p)
 4. iAdam1n, aka **** ******
 5. hizinfiz
 6. Hipp013
 */

#import "DowngradeViewController.h"
#import "ViewController.h"
#define explode(what, delimiter) [what componentsSeparatedByString: delimiter] //php forever

@interface DowngradeViewController ()

@end

@implementation DowngradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)restoreWithCommand:(NSMutableString *)command {
    
   NSArray *args = explode(command, @" ");
    
    self.status.string = [NSString stringWithFormat:@"$(futurerestore %@);", command];
    
    
    NSTask *taskz = [[NSTask alloc]init];
    
    taskz.launchPath = @"/usr/local/bin/futurerestore";
    [taskz setArguments:args];
    
    
    [self captureStandardOutput:taskz];
    [taskz launch];
    
}
    
  -(void)captureStandardOutput:(NSTask *)process {
      
      //go go go
      
    self.outputPipe = [NSPipe new];
    process.standardOutput = self.outputPipe;
      process.standardError = self.outputPipe;
      
     [self.outputPipe.fileHandleForReading waitForDataInBackgroundAndNotifyForModes:[NSArray arrayWithObjects:NSModalPanelRunLoopMode, nil]];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NSFileHandleDataAvailableNotification object:self.outputPipe.fileHandleForReading queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        NSData *output = self.outputPipe.fileHandleForReading.availableData;
        NSString *outputString = [[NSString alloc] initWithData:output encoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(![outputString isEqualToString:@""] && ![outputString isEqualToString:@"\n"]) {
            self.status.string = [NSString stringWithFormat:@"%@\n%@", self.status.string, outputString];
                [self.status scrollRangeToVisible: NSMakeRange(self.status.string.length, 0)];
            }
        });
        

       [self.outputPipe.fileHandleForReading waitForDataInBackgroundAndNotifyForModes:[NSArray arrayWithObjects:NSModalPanelRunLoopMode, nil]];
        
    }];
     
}
@end
