#import "MainController.h"

#import "ActionDispatcher.h"
#import "Growl.h"
#import "NotificationManager.h"
#import "Preferences.h"

@implementation MainController

- (NSImage *)prepareImageForMenubar:(NSString *)name {
	NSImage *img = [NSImage imageNamed:name];
	[img setScalesWhenResized:YES];
	[img setSize:NSMakeSize(18, 18)];
  
	return img;
}

- (void)awakeFromNib {
  // Setup the menubar item
  statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
  [statusItem setHighlightMode:YES];
  [statusItem setImage:[self prepareImageForMenubar:@"menuicon"]];
  [statusItem setMenu:menu];

  // TODO(rdamazio): Move to UI binding
  notificationManager =
      [[NotificationManager alloc] initWithDispatcher:actionDispatcher
                                  withPairingCallback:preferences];
}

- (void)dealloc {
  [notificationManager release];
  [statusItem release];
  [super dealloc];
}

- (IBAction)showAboutDialog:(id)sender {
  [NSApp activateIgnoringOtherApps:YES];
  [aboutDialog makeKeyAndOrderFront:sender];
}

- (IBAction)quit:(id)sender {
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  [ud synchronize];
  [NSApp terminate:self];
}

@end