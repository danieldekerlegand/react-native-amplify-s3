#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(AmplifyS3, NSObject)

RCT_EXTERN_METHOD(setup
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(uploadFile
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
