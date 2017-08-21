//
//  ViewController.h
//  Prometheus
//
//  Created by Jake James on 6/23/17.
//  Copyright © 2017 Jake James. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
{
    @public
    NSMutableString *cmd;
}
@property (weak) IBOutlet NSTextFieldCell *devicename;

@property (weak) IBOutlet NSTextField *ipswPath;
@property (weak) IBOutlet NSButton *jbken;
@property (weak) IBOutlet NSButton *debug;
@property (weak) IBOutlet NSButton *downgrade;
@property (weak) IBOutlet NSButton *ipsw;

@property (weak) IBOutlet NSButton *nobaseband;

@property (weak) IBOutlet NSButton *useLF;
@property (weak) IBOutlet NSTextField *Sipswpath;
@property (weak) IBOutlet NSButton *Sipsw;

@property (weak) IBOutlet NSTextField *statusLabel;
@property (weak) IBOutlet NSTextField *status;

@property (weak) IBOutlet NSTextField *blobsPath;
@property (weak) IBOutlet NSButton *chooseBlobs;


@end


