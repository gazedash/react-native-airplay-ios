

#import <React/RCTEventEmitter.h>
#import <React/RCTBridge.h>



@interface RCT_EXTERN_MODULE(AirPlay, RCTEventEmitter)

RCT_EXTERN_METHOD(startScan)
RCT_EXTERN_METHOD(isAlredyConnected:(RCTResponseSenderBlock)callback)

@end
