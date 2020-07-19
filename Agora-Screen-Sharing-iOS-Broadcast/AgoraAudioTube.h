
//
//  Created by Apiphoom Chuenchompoo on 2020/5/23.
//  Copyright © 2020 ApiDevelopment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

typedef NS_OPTIONS(NSUInteger, AudioType) {
    AudioTypeApp = 1,
    AudioTypeMic = 2
};

@interface AgoraAudioTube : NSObject
+ (void)agoraKit:(AgoraRtcEngineKit * _Nonnull)agoraKit pushAudioCMSampleBuffer:(CMSampleBufferRef _Nonnull)sampleBuffer resampleRate:(NSUInteger)resampleRate type:(AudioType)type;
@end
