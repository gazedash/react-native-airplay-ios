#import "RNAirplay.h"
#import "RNAirplayManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>


@implementation RNAirplay
@synthesize bridge = _bridge;

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(startScan)
{
    printf("init Airplay");
    AVAudioSessionRouteDescription* currentRoute = [[AVAudioSession sharedInstance] currentRoute];
    BOOL isAvailable = false;
    NSUInteger routeNum = [[currentRoute outputs] count];
    if(routeNum > 0) {
        isAvailable = true;
        BOOL isConnected = true;
        for (AVAudioSessionPortDescription * output in currentRoute.outputs) {
            if([output.portType isEqualToString:AVAudioSessionPortAirPlay]) {
                [self sendEventWithName:@"airplayConnected" body:@{@"connected": @(isConnected)}];
            }
        }
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector: @selector(airplayChanged:)
         name:AVAudioSessionRouteChangeNotification
         object:[AVAudioSession sharedInstance]];

    }

    [self sendEventWithName:@"airplayAvailable" body:@{@"available": @(isAvailable)}];
}

RCT_EXPORT_METHOD(disconnect)
{
    printf("disconnect Airplay");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self sendEventWithName:@"airplayAvailable" body:@{@"available": @(false) }];
}


- (void)airplayChanged:(NSNotification *)sender
{
    AVAudioSessionRouteDescription* currentRoute = [[AVAudioSession sharedInstance] currentRoute];
    BOOL isAirPlayPlaying = false;
    for (AVAudioSessionPortDescription * output in currentRoute.outputs) {
        if([output.portType isEqualToString:AVAudioSessionPortAirPlay]) {
            isAirPlayPlaying = true;
            break;
        }
    }
    [self sendEventWithName:@"airplayConnected" body:@{@"connected": @(isAirPlayPlaying)}];
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"airplayAvailable", @"airplayConnected"];
}


@end
