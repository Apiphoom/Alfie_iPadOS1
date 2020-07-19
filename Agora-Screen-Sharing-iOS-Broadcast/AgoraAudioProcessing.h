
//
//  Created by Apiphoom Chuenchompoo on 2020/5/23.
//  Copyright © 2020 ApiDevelopment. All rights reserved.
//

#import <CoreMedia/CoreMedia.h>
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

@interface AgoraAudioProcessing : NSObject
+ (void)registerAudioPreprocessing:(AgoraRtcEngineKit*) kit;
+ (void)deregisterAudioPreprocessing:(AgoraRtcEngineKit*) kit;
+ (void)pushAudioFrame:(unsigned char *)inAudioFrame withFrameSize:(int64_t)frameSize;
@end
