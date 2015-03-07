//
//  AppDelegate.m
//  VLCX
//
//  Created by Latchezar Tzvetkoff on 2015-01-04.
//  Copyright (c) 2015 Latchezar Tzvetkoff. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

static NSMutableArray *openFiles = nil;

- (id)init {
    if (self = [super init]) {
        openFiles = [NSMutableArray array];
    }

    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // construct the new execl parameters
    char **nargv = calloc(sizeof(char *), [openFiles count] + 3 + 1);
    nargv[0] = "/usr/bin/open";
    nargv[1] = "-na";
    nargv[2] = "/Applications/VLC.app";
    for (int i = 0; i < [openFiles count]; ++i) {
        nargv[i + 3] = (char *)[[openFiles objectAtIndex:i] UTF8String];
    }

    // execute teh vlc!
    execv(nargv[0], nargv);
    exit(0);
}

- (void)application:(NSApplication *)sender openFiles:(NSArray *)filenames {
    for (int i = 0; i < [filenames count]; ++i) {
        [openFiles addObject:[filenames objectAtIndex:i]];
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
