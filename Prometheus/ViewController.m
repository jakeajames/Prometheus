//
//  ViewController.m
//  Prometheus
//
//  Created by Jake James on 6/23/17.
//  Copyright © 2017 Jake James. All rights reserved.
// People who can't use this software:
/*
 1. nullpixel aka nullriver aka Jamie Bishop aka Jane Bishop aka nullbrain
 2. 1Conan aka Conan edogavablablah
 3. Blu3Dev aka Blu3_dev aka BSDIsShit (I know your secret :p xd)
 4. iAdam1n, aka Adam Insull
 5. hizinfiz
 6. Hipp013
 */

#import "ViewController.h"
#import "DowngradeViewController.h"

//NSMutableString *cmd;
NSMutableString *str;

BOOL success1 = NO;
BOOL success2 = NO;
BOOL success3 = NO;
@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];


    // Do any additional setup after loading the view.
}
- (IBAction)chooseSipsw:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:NO];
    
    NSInteger clicked = [panel runModal];
    
    if (clicked == NSFileHandlingPanelOKButton) {
        for (NSURL *url in [panel URLs]) {
            self.Sipswpath.stringValue = [[NSString alloc] initWithFormat: @"%@", [[url absoluteString] stringByReplacingOccurrencesOfString:@"file://" withString:@""]];
        }
    }

}
- (IBAction)blobsBtn:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:NO];
    
    NSInteger clicked = [panel runModal];
    
    if (clicked == NSFileHandlingPanelOKButton) {
        for (NSURL *url in [panel URLs]) {
            self.blobsPath.stringValue = [[NSString alloc] initWithFormat: @"%@", [[url absoluteString] stringByReplacingOccurrencesOfString:@"file://" withString:@""]];
        }
    }
    
}

- (IBAction)chooseIPSW:(id)sender {
    
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:NO];
    
    NSInteger clicked = [panel runModal];
    
    if (clicked == NSFileHandlingPanelOKButton) {
        for (NSURL *url in [panel URLs]) {
            self.ipswPath.stringValue = [[NSString alloc] initWithFormat: @"%@", [[url absoluteString] stringByReplacingOccurrencesOfString:@"file://" withString:@""]];
        }
    }

    
}
- (IBAction)useLF:(id)sender {
   /* if ([sender state] == NSOnState) {
        [_Sipswpath setEnabled:NO];
        [_Sipsw setEnabled:NO];
    }
    else {
        [_Sipswpath setEnabled:YES];
        [_Sipsw setEnabled:YES];
    }
    */
    //Danger, Will Robinson!!
}
- (IBAction)debug:(id)sender {
    if ([sender state] == NSOnState) {
        /* NSAlert *alert = [[NSAlert alloc] init];
        
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"Logs"];
        [alert setInformativeText:@"Debug logs will be saved at ~/Prometheus/debug_log.txt"];
        [alert runModal]; */
    }
    else {
       
        NSAlert *alert = [[NSAlert alloc] init];
        
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"Logs"];
        [alert setInformativeText:@"It is reccomended to switch debug mode on"];
        [alert runModal];

        
    }
}


-(void)viewDidAppear {
    [super viewDidAppear];
    
    NSAlert *alert = [[NSAlert alloc] init];
    
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:@"Logs"];
    [alert setInformativeText:@"It is reccomended to switch debug mode on"];
    [alert runModal];

    
     dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
      while(true) {
             
        NSPipe *pipe = [NSPipe pipe];
        
        NSTask *task = [[NSTask alloc]init];
        
        task.launchPath = @"/usr/local/bin/idevicename";
        [task setStandardOutput: pipe];
        [task launch];
        [task waitUntilExit];
        
        NSFileHandle *file = [pipe fileHandleForReading];
        NSData *data = [file readDataToEndOfFile];
        NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [file closeFile];
             
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if ([output isEqualToString:@""]) {
                
                [_ipswPath setEnabled:NO];
                [_jbken setEnabled:NO];
                [_debug setEnabled:NO];
                [_downgrade setEnabled:NO];
                [_ipsw setEnabled:NO];
                [_useLF setEnabled:NO];
                [_blobsPath setEnabled:NO];
                [_chooseBlobs setEnabled:NO];
                [_Sipsw setEnabled:NO];
                [_Sipswpath setEnabled:NO];
                self.devicename.stringValue = @"No device detected";
            }
            else {
                self.devicename.stringValue = output;
                [_ipswPath setEnabled:YES];
                [_jbken setEnabled:YES];
                [_debug setEnabled:YES];
                [_downgrade setEnabled:YES];
                [_ipsw setEnabled:YES];
               // [_useLF setEnabled:YES]; don't enable this or your device will explode
                [_blobsPath setEnabled:YES];
                [_chooseBlobs setEnabled:YES];
                if ([self.useLF state] != NSOnState) {
                [_Sipsw setEnabled:YES];
                [_Sipswpath setEnabled:YES];
                }
                else {
                    [_Sipsw setEnabled:NO];
                    [_Sipswpath setEnabled:NO];
                }
            }
        });
         }
    });
    
    

}





- (void)asynchronousTaskWithCompletion:(void (^)(void))completion;
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, kNilOptions), ^{
        
        system([str UTF8String]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
        });
    });
}
- (IBAction)downgrade:(id)sender {
    //doit = NO;
    
    if ([self.blobsPath.stringValue isEqualToString:@""]) {
        NSAlert *alert = [[NSAlert alloc] init];
        
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"Blobs"];
        [alert setInformativeText:@"No blobs found. Please specify SHSH blobs"];
        [alert runModal];
        success1 = NO;
        
    }
    else {
       cmd = [NSMutableString stringWithFormat:@"-t %@ ", self.blobsPath.stringValue];
        success1 = YES;
     }
         
    
    
    if (self.useLF.state == NSControlStateValueOn && self.nobaseband.state == NSControlStateValueOff) {
        [cmd appendString:@"--latest-baseband --latest-sep "];
        success2 = YES;
    }
    else if (self.useLF.state == NSControlStateValueOn && self.nobaseband.state == NSControlStateValueOn) {
        
        [cmd appendString:@"--no-baseband --latest-sep "];
        success2 = YES;
        
    }
    else if (self.useLF.state == NSControlStateValueOff && self.nobaseband.state == NSControlStateValueOff){
        
        if ([self.Sipswpath.stringValue isEqualToString:@""]) {
            NSAlert *alert = [[NSAlert alloc] init];
            
            [alert addButtonWithTitle:@"OK"];
            [alert setMessageText:@"Firmware"];
            [alert setInformativeText:@"If you don't check latest baseband and sep you have to specify a signed ipsw file manually"];
            [alert runModal];
            success2 = NO;
            
        }
        else {
            
            NSPipe *pip = [NSPipe pipe];
            NSTask *taskz = [[NSTask alloc]init];
            taskz.launchPath = @"/usr/local/bin/ideviceinfo";
            [taskz setArguments:[NSArray arrayWithObjects:@"-k", @"HardwareModel", nil]];
            [taskz setStandardOutput: pip];
            [taskz launch];
            [taskz waitUntilExit];
            NSFileHandle *filez = [pip fileHandleForReading];
            NSData *dataz = [filez readDataToEndOfFile];
            NSString *board = [[NSString alloc] initWithData:dataz encoding:NSUTF8StringEncoding];
            [filez closeFile];
            
            str = [NSMutableString stringWithFormat:@"cd ~; mkdir Prometheus; cd Prometheus; mkdir files; cp %@ files; cd files; mkdir .fw; unzip %@ -d .fw; cd .fw; mv BuildManifest.plist ..;", self.Sipswpath.stringValue, self.Sipswpath.stringValue];
            
            
            if ([[self.ipswPath.stringValue pathExtension] isEqualToString:@"ipsw"] && [[self.Sipswpath.stringValue pathExtension] isEqualToString:@"ipsw"] && ([[self.blobsPath.stringValue pathExtension] isEqualToString:@"shsh"] || [[self.blobsPath.stringValue pathExtension] isEqualToString:@"shsh2"])) {
                
                [self.status setEnabled:YES];
                self.status.hidden = NO;
                
            self.status.stringValue = @"Extracting ipsw...";
            system("rm -rf ~/Prometheus/files");
            [self asynchronousTaskWithCompletion:^{
               /* NSAlert *alert = [[NSAlert alloc] init];
                
                [alert addButtonWithTitle:@"OK"];
                [alert setMessageText:@"DONE"];
                [alert setInformativeText:board];
                [alert runModal]; */
                NSLog(@"%@", NSHomeDirectory());
                self.status.stringValue = @"Copying files...";
                
                system([[NSString stringWithFormat:@"cd ~/Prometheus/files; echo $(/bin/sh /usr/bin/baseband_path %@ BuildManifest.plist) > path.txt; echo $(ls ~/Prometheus/files/sep*.im4p) > sep.txt", [[board lowercaseString] stringByReplacingOccurrencesOfString:@"\n" withString:@""]] UTF8String]);
                
                NSString* content = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/Prometheus/files/path.txt", NSHomeDirectory()]
                                                              encoding:NSUTF8StringEncoding
                                                                 error:NULL];
                
                str = [NSMutableString stringWithFormat:@"cd %@/Prometheus/files/.fw; mv Firmware/all_flash/sep*%@*.im4p ..; mv %@ ..; cd ..; rm -rf .fw; rm -rf *.ipsw;", NSHomeDirectory(), [[[board lowercaseString] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@"ap" withString:@""], [content stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
                
                
                //NSLog(@"loooooool%@", output2);
                
                
                [self asynchronousTaskWithCompletion:^{
                    
                    self.status.stringValue = @"Starting downgrade...";
                    sleep(3);
                    //NSString *sb = @"MainStoryboard";
                    //NSStoryboard *stb = [NSStoryboard storyboardWithName:sb bundle:nil];
                    NSStoryboard *stb = self.storyboard;
                    
                    DowngradeViewController *vc = [stb instantiateControllerWithIdentifier:@"DowngradeViewController"];
                    //DowngradeViewController *vv = [[DowngradeViewController alloc] initWithCommand:cmd];
                    
                    
                    [self presentViewControllerAsModalWindow:vc];
                    [vc restoreWithCommand:cmd];
                    // [self presentV]
                    
                }];
                
            }];
            
                
                
                NSString* sep = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/Prometheus/files/sep.txt", NSHomeDirectory()]
                                                              encoding:NSUTF8StringEncoding
                                                                 error:NULL];
                NSString* bb = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/Prometheus/files/path.txt", NSHomeDirectory()]
                                                          encoding:NSUTF8StringEncoding
                                                             error:NULL];
                
            NSMutableString *sepAndBase = [NSMutableString stringWithFormat:@"-b %@/Prometheus/files/%@ -p %@/Prometheus/files/BuildManifest.plist -s %@ -m %@/Prometheus/files/BuildManifest.plist ", NSHomeDirectory(), bb,  NSHomeDirectory(), sep, NSHomeDirectory()];
            [cmd appendString:sepAndBase];
            
            
        }
            else if ([[self.ipswPath.stringValue pathExtension] isEqualToString:@"ipsw"] && [[self.Sipswpath.stringValue pathExtension] isEqualToString:@"ipsw"] && (![[self.blobsPath.stringValue pathExtension] isEqualToString:@"shsh"] || ![[self.blobsPath.stringValue pathExtension] isEqualToString:@"shsh2"])) {
                NSAlert *alert = [[NSAlert alloc] init];
                
                [alert addButtonWithTitle:@"OK"];
                [alert setMessageText:@"SHSH"];
                [alert setInformativeText:@"Invalid blobs"];
                [alert runModal];
                success2 = NO;
                
            }
            else {
                NSAlert *alert = [[NSAlert alloc] init];
                
                [alert addButtonWithTitle:@"OK"];
                [alert setMessageText:@"ipsw"];
                [alert setInformativeText:@"One of the ipsw files is not valid"];
                [alert runModal];
                success2 = NO;
            }
        }
    }
    
    else if (self.useLF.state == NSControlStateValueOff && self.nobaseband.state == NSControlStateValueOn) {
        
        if ([self.Sipswpath.stringValue isEqualToString:@""]) {
            NSAlert *alert = [[NSAlert alloc] init];
            
            [alert addButtonWithTitle:@"OK"];
            [alert setMessageText:@"Firmware"];
            [alert setInformativeText:@"If you don't check latest baseband and sep you have to specify a signed ipsw file manually"];
            [alert runModal];
            success2 = NO;
            
        }
        else {
            
            NSPipe *pip = [NSPipe pipe];
            NSTask *taskz = [[NSTask alloc]init];
            taskz.launchPath = @"/usr/local/bin/ideviceinfo";
            [taskz setArguments:[NSArray arrayWithObjects:@"-k", @"HardwareModel", nil]];
            [taskz setStandardOutput: pip];
            [taskz launch];
            [taskz waitUntilExit];
            NSFileHandle *filez = [pip fileHandleForReading];
            NSData *dataz = [filez readDataToEndOfFile];
            NSString *board = [[NSString alloc] initWithData:dataz encoding:NSUTF8StringEncoding];
            [filez closeFile];
            
            str = [NSMutableString stringWithFormat:@"cd ~; mkdir Prometheus; cd Prometheus; mkdir files; cp %@ files; cd files; mkdir .fw; unzip %@ -d .fw; cd .fw; mv BuildManifest.plist ..;", self.Sipswpath.stringValue, self.Sipswpath.stringValue];
            
            
            
            if ([[self.ipswPath.stringValue pathExtension] isEqualToString:@"ipsw"] && [[self.Sipswpath.stringValue pathExtension] isEqualToString:@"ipsw"] && ([[self.blobsPath.stringValue pathExtension] isEqualToString:@"shsh"] || [[self.blobsPath.stringValue pathExtension] isEqualToString:@"shsh2"])) {
                
                [self.status setEnabled:YES];
                self.status.hidden = NO;
                self.status.stringValue = @"Extracting ipsw...";
                
                [self asynchronousTaskWithCompletion:^{
                    /* NSAlert *alert = [[NSAlert alloc] init];
                     
                     [alert addButtonWithTitle:@"OK"];
                     [alert setMessageText:@"DONE"];
                     [alert setInformativeText:board];
                     [alert runModal]; */
                    NSLog(@"%@", NSHomeDirectory());
                    self.status.stringValue = @"Copying files...";
                    
                    
                    
                    
                    str = [NSMutableString stringWithFormat:@"cd %@/Prometheus/files/.fw; mv Firmware/all_flash/sep*%@*.im4p ..; cd ..; rm -rf .fw; rm -rf *.ipsw;", NSHomeDirectory(), [[[board lowercaseString] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@"ap" withString:@""]];
                    
                    
                    //NSLog(@"loooooool%@", output2);
                    
                    
                    [self asynchronousTaskWithCompletion:^{
                        
                        self.status.stringValue = @"Starting downgrade...";
                        
                        sleep(3);
                        //NSString *sb = @"MainStoryboard";
                        //NSStoryboard *stb = [NSStoryboard storyboardWithName:sb bundle:nil];
                        NSStoryboard *stb = self.storyboard;
                        
                        DowngradeViewController *vc = [stb instantiateControllerWithIdentifier:@"DowngradeViewController"];
                        //DowngradeViewController *vv = [[DowngradeViewController alloc] initWithCommand:cmd];
                        
                        
                        [self presentViewControllerAsModalWindow:vc];
                        [vc restoreWithCommand:cmd];
                        // [self presentV]
                        
                    }];
                    
                }];
                
                
                
                NSMutableString *sepAndBase = [NSMutableString stringWithFormat:@"--no-baseband -s %@/Prometheus/files/sep*.im4p -m %@/Prometheus/files/BuildManifest.plist ",  NSHomeDirectory(), NSHomeDirectory()];
                [cmd appendString:sepAndBase];
                
                
            }
            else if ([[self.ipswPath.stringValue pathExtension] isEqualToString:@"ipsw"] && [[self.Sipswpath.stringValue pathExtension] isEqualToString:@"ipsw"] && (![[self.blobsPath.stringValue pathExtension] isEqualToString:@"shsh"] || ![[self.blobsPath.stringValue pathExtension] isEqualToString:@"shsh2"])) {
                NSAlert *alert = [[NSAlert alloc] init];
                
                [alert addButtonWithTitle:@"OK"];
                [alert setMessageText:@"SHSH"];
                [alert setInformativeText:@"Invalid blobs"];
                [alert runModal];
                success2 = NO;
                
            }
            else {
                NSAlert *alert = [[NSAlert alloc] init];
                
                [alert addButtonWithTitle:@"OK"];
                [alert setMessageText:@"ipsw"];
                [alert setInformativeText:@"One of the ipsw files is not valid"];
                [alert runModal];
                success2 = NO;
            }
        }
    }
    
    if (_jbken.state != NSControlStateValueOn) {
        [cmd appendString:@"-w "];
    }
    
    if (_debug.state == NSControlStateValueOn) {
        [cmd appendString:@"-d "];
    }
    if ([self.ipswPath.stringValue isEqualToString:@""]) {
        NSAlert *alert = [[NSAlert alloc] init];
        
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"Target"];
        [alert setInformativeText:@"No target ipsw found. Please specify your target ipsw"];
        [alert runModal];
        success3 = NO;
    }
    else {
        
        [cmd appendFormat:@"%@",self.ipswPath.stringValue];
        success3 = YES;
        
    }
    
    if (success1 && success2 && success3) {
        
        
        sleep(3);
         self.status.stringValue = @"";
        //NSString *sb = @"MainStoryboard";
        //NSStoryboard *stb = [NSStoryboard storyboardWithName:sb bundle:nil];
        NSStoryboard *stb = self.storyboard;
        
        DowngradeViewController *vc = [stb instantiateControllerWithIdentifier:@"DowngradeViewController"];
        //DowngradeViewController *vv = [[DowngradeViewController alloc] initWithCommand:cmd];
        
        
        [self presentViewControllerAsModalWindow:vc];
         [vc restoreWithCommand:cmd];
       // [self presentV]
    }
    else {
        NSLog(@"1 - %hhd \n2 - %hhd \n3 - %hhd", success1, success2, success3);
    }
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
