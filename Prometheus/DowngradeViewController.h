//
//  DowngradeViewController.h
//  Prometheus
//
//  Created by Jake James on 7/28/17.
//  Copyright © 2017 Jake James. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DowngradeViewController : NSViewController
@property (unsafe_unretained) IBOutlet NSTextView *status;

@property NSPipe *outputPipe;
-(void)restoreWithCommand:(NSMutableString *)command;
@end
