
//
//  Created by Apiphoom Chuenchompoo on 2020/5/23.
//  Copyright © 2020 ApiDevelopment. All rights reserved.
//
import ReplayKit
import CoreData

class SampleHandler: RPBroadcastSampleHandler {
    
    override func broadcastStarted(withSetupInfo setupInfo: [String : NSObject]?) {
        
        
        let defaults = UserDefaults(suiteName: "group.com.apiphoom.Alfie-1.API")
        let IDS = defaults?.string(forKey: "API")
        
        if let setupInfo = setupInfo, let channel = setupInfo["channelName"] as? String {
            //In-App Screen Capture
            AgoraUploader.startBroadcast(to: channel)
        } else {
            //iOS Screen Record and Broadcast
            print(IDS!)
            print("start broadcast")
        AgoraUploader.startBroadcast(to:IDS!)
        }
    }
    
    override func broadcastPaused() {
        // User has requested to pause the broadcast. Samples will stop being delivered.
    }
    
    override func broadcastResumed() {
        // User has requested to resume the broadcast. Samples delivery will resume.
    }
    
    override func broadcastFinished() {
        AgoraUploader.stopBroadcast()
    }
    
    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        DispatchQueue.main.async {
            switch sampleBufferType {
            case .video:
                AgoraUploader.sendVideoBuffer(sampleBuffer)
            case .audioApp:
                AgoraUploader.sendAudioAppBuffer(sampleBuffer)
            case .audioMic:
                AgoraUploader.sendAudioMicBuffer(sampleBuffer)
            @unknown default:
                break
            }
        }
    }
}

