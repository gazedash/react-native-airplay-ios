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
        AVAudioSessionRouteDescription* currentRoute =[[AVAudioSession sharedInstance] currentRoute];
        int routeCount = (int)[[currentRoute outputs] count];
        NSString* deviceName;
        NSString* portType;
        for (AVAudioSessionPortDescription * output in currentRoute.outputs) {
            deviceName = output.portName;
            portType = output.portType;
            [self sendEventWithName:@"deviceConnected" body:@{@"deviceName": deviceName, @"portType": portType}];
        }

        [[NSNotificationCenter defaultCenter]
        addObserver:self
        selector: @selector(deviceChanged:)
        name:AVAudioSessionRouteChangeNotification
        object:[AVAudioSession sharedInstance]];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self getConnectedDevice];
        });
        }

RCT_EXPORT_METHOD(disconnect)
        {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        }


- (void)deviceChanged:(NSNotification *)sender {
    AVAudioSessionRouteDescription *currentRoute = [[AVAudioSession sharedInstance] currentRoute];
    NSString *deviceName;
    NSString *portType;
    for (AVAudioSessionPortDescription *output in currentRoute.outputs) {
        deviceName = output.portName;
        portType = output.portType;
        [self sendEventWithName:@"deviceConnected" body:@{@"deviceName": deviceName, @"portType": portType}];
    }
}

- (void) getConnectedDevice;
{
    AVAudioSessionRouteDescription *currentRoute = [[AVAudioSession sharedInstance] currentRoute];
    NSString *deviceName;
    NSString *portType;
    for (AVAudioSessionPortDescription *output in currentRoute.outputs) {
        deviceName = output.portName;
        portType = output.portType;
        [self sendEventWithName:@"deviceConnected" body:@{@"deviceName": deviceName, @"portType": portType}];
    }
}


- (NSArray<NSString *> *)supportedEvents {
    return @[@"deviceConnected"];
}

@end
