#import "RNAirplay.h"
#import "RNAirplayButton.h"
#import <React/RCTLog.h>
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
    AVAudioSessionRouteDescription* currentRoute = [[AVAudioSession sharedInstance] currentRoute];
    BOOL isAvailable = false;
    NSUInteger routeNum = [[currentRoute outputs] count];
    
    if(routeNum > 0) {
        isAvailable = true;
        for (AVAudioSessionPortDescription * output in currentRoute.outputs) {
            if(output.portType == AVAudioSessionPortAirPlay) {
                [self sendEventWithName:@"airplayConnected" body:@{@"connected": @true}];
            }
        }
        
    }
    
    [self sendEventWithName:@"airplayAvailable" body:@{@"available": @true}];
}

RCT_EXPORT_METHOD(airplayChanged:(NSNotification*)sender)
{
    AVAudioSessionRouteDescription* currentRoute = [[AVAudioSession sharedInstance] currentRoute];
    BOOL isAirPlayPlaying = false;
    for (AVAudioSessionPortDescription * output in currentRoute.outputs) {
        if(output.portType == AVAudioSessionPortAirPlay) {
            RCTLogInfo(@"Airplay Device connected with name:", output.portName);
            isAirPlayPlaying = true;
            break;
        }
    }
    [self sendEventWithName:@"airplayConnected" body:@{@"available": @true}];
}


@end
