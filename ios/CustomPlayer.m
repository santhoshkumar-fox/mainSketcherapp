
#import "React/RCTViewManager.h"
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(CustomPlayer, RCTViewManager)
RCT_EXPORT_VIEW_PROPERTY(strokeWidth, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(applepencile, BOOL)
RCT_EXPORT_VIEW_PROPERTY(positionArray, NSArray)
//RCT_EXTERN_METHOD(increment:(RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(save:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(redo:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(undo:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(reset:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(eraser:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(pen:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
@end
