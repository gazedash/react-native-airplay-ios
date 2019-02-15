#import "RNAirplay.h"
#import "RNAirplayManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>


@implementation RNAirplay
@synthesize bridge = _bridge;

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(startScan)
        {
                printf("init Airplay");
        AVAudioSessionRouteDescription* currentRoute =[[AVAudioSession sharedInstance] currentRoute];
        BOOL isAvailable = false;
        int routeCount = (int)[[currentRoute outputs] count];
//        isAvailable = true;
        BOOL isConnected = true;
        NSString* deviceName;
        NSString* portType;
        for (AVAudioSessionPortDescription * output in currentRoute.outputs) {
            deviceName = output.portName;
            portType = output.portType;
            // NSString avp = AVAudioSessionPort;
            [self sendEventWithName:@"airplayConnected" body:@{@"connected": @(false), @"deviceName": deviceName, @"portType": portType}];
            // if([output.portType isEqualToString:AVAudioSessionPort]) {
            // }
        }
        [[NSNotificationCenter defaultCenter]
        addObserver:self
        selector: @selector(airplayChanged:)
        name:AVAudioSessionRouteChangeNotification
        object:[AVAudioSession sharedInstance]];

        [self sendEventWithName:@"airplayAvailable" body:@{
            @"available": @(isAvailable)
        }];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self isAvailable];
        });
        }

RCT_EXPORT_METHOD(disconnect)
        {
                printf("disconnect Airplay");
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self sendEventWithName:@"airplayAvailable" body:@{
            @"available": @(false)
        }];
        }


- (void)airplayChanged:(NSNotification *)sender {
    AVAudioSessionRouteDescription *currentRoute = [[AVAudioSession sharedInstance] currentRoute];
    BOOL isAirPlayPlaying = false;
    NSString *deviceName;

    NSString *portType;
    for (AVAudioSessionPortDescription *output in currentRoute.outputs) {
        deviceName = output.portName;
        portType = output.portType;
        // NSString avp = AVAudioSessionPort;
        [self sendEventWithName:@"airplayConnected" body:@{@"connected": @(false), @"deviceName": deviceName, @"portType": portType}];
        // if ([output.portType isEqualToString:avp]) {
        //     isAirPlayPlaying = true;
        //     break;
        // }
    }
}

- (void)isAvailable; {
    printf("init Available");
    AVAudioSessionRouteDescription *currentRoute = [[AVAudioSession sharedInstance] currentRoute];
    BOOL isAvailable = false;
    int routeCount = (int) [[currentRoute outputs] count];
    if (routeCount > 1) {
        isAvailable = true;
    }
    [self sendEventWithName:@"airplayAvailable" body:@{@"available": @(isAvailable)}];
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"airplayAvailable", @"airplayConnected"];
}


@end
