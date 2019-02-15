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
        NSString* deviceName;
        NSString* portType;
        // Get current audio output
        AVAudioSessionRouteDescription* currentRoute =[[AVAudioSession sharedInstance] currentRoute];
        // There *might* be several audio outputs, altough I wasn't able to test it
        // With my setups e.g. headphones, bluetooth devices, Apple TV - there is only one device at a time
        for (AVAudioSessionPortDescription * output in currentRoute.outputs) {
            deviceName = output.portName;
            portType = output.portType;
            [self sendEventWithName:@"deviceConnected" body:@{@"deviceName": deviceName, @"portType": portType}];
        }

        // Add observer which will call "deviceChanged" method when audio outpout changes
        // e.g. headphones connect / disconnect
        [[NSNotificationCenter defaultCenter]
        addObserver:self
        selector: @selector(deviceChanged:)
        name:AVAudioSessionRouteChangeNotification
        object:[AVAudioSession sharedInstance]];

        // also call getConnectedDevice method immediately to send currently connected device
        // at the time of startScan
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
        // deviceName: e.g. "My bluetooth headphones"
        deviceName = output.portName;
        // portType: the type of connection, e.g. "BluetoothA2DPOutput", "Speaker" or "AirPlay"
        portType = output.portType;
        // send an event to React Native listener
        [self sendEventWithName:@"deviceConnected" body:@{@"deviceName": deviceName, @"portType": portType}];
    }
}

- (void) getConnectedDevice;
{
    AVAudioSessionRouteDescription *currentRoute = [[AVAudioSession sharedInstance] currentRoute];
    NSString *deviceName;
    NSString *portType;
    for (AVAudioSessionPortDescription *output in currentRoute.outputs) {
        // deviceName: e.g. "My bluetooth headphones"
        deviceName = output.portName;
        // portType: the type of connection, e.g. "BluetoothA2DPOutput", "Speaker" or "AirPlay"
        portType = output.portType;
        // send an event to React Native listener
        [self sendEventWithName:@"deviceConnected" body:@{@"deviceName": deviceName, @"portType": portType}];
    }
}


- (NSArray<NSString *> *)supportedEvents {
    return @[@"deviceConnected"];
}

@end
