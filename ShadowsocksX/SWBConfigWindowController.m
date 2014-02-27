//
// Created by clowwindy on 14-2-26.
// Copyright (c) 2014 clowwindy. All rights reserved.
//

#import "SWBConfigWindowController.h"
#import "ShadowsocksRunner.h"


@implementation SWBConfigWindowController {

}


- (void)windowWillLoad {
    [super windowWillLoad];
    [self loadSettings];
}

- (void)loadSettings {
    if ([ShadowsocksRunner isUsingPublicServer]) {
        [_publicMatrix selectCellAtRow:0 column:0];
    } else {
        [_publicMatrix selectCellAtRow:0 column:1];
    }
    [_serverField setStringValue:[ShadowsocksRunner configForKey:kShadowsocksIPKey]];
    [_portField setStringValue:[ShadowsocksRunner configForKey:kShadowsocksPortKey]];
    [_passwordField setStringValue:[ShadowsocksRunner configForKey:kShadowsocksPasswordKey]];
    [_methodBox setStringValue:[ShadowsocksRunner configForKey:kShadowsocksEncryptionKey]];
}

- (void)saveSettings {
    if (_publicMatrix.selectedColumn == 0) {
        [ShadowsocksRunner setUsingPublicServer:YES];
    } else {
        [ShadowsocksRunner setUsingPublicServer:NO];
        [ShadowsocksRunner saveConfigForKey:kShadowsocksIPKey value:[_serverField stringValue]];
        [ShadowsocksRunner saveConfigForKey:kShadowsocksPortKey value:[_portField stringValue]];
        [ShadowsocksRunner saveConfigForKey:kShadowsocksPasswordKey value:[_passwordField stringValue]];
        [ShadowsocksRunner saveConfigForKey:kShadowsocksEncryptionKey value:[_methodBox stringValue]];
    }
}

- (void)windowDidLoad {
    [self updateSettingsBoxVisible:self];
}

- (IBAction)updateSettingsBoxVisible:(id)sender {
    if (_publicMatrix.selectedColumn == 0) {
        [_settingsBox setHidden:YES];
    } else {
        [_settingsBox setHidden:NO];
    }
}

- (IBAction)OK:(id)sender {
    [self saveSettings];
    [ShadowsocksRunner reloadConfig];
    [self.window performClose:self];
}

- (IBAction)cancel:(id)sender {
    [self.window performClose:self];
}


@end