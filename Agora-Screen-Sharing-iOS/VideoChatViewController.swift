//
//
//  Created by Apiphoom Chuenchompoo on 2020/5/23.
//  Copyright © 2020 ApiDevelopment. All rights reserved.
//
//
import UIKit
import AgoraRtcKit
import ReplayKit
import CoreData


class VideoChatViewController: UIViewController {
 
    @IBOutlet weak var localVideo: UIView!
    @IBOutlet weak var remoteVideo: UIView!
    @IBOutlet weak var ClassroomLabel: UILabel!
    @IBOutlet weak var remoteVideoMutedIndicator: UIImageView!
    @IBOutlet weak var localVideoMutedIndicator: UIView!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var ShareScreen: Round_Button!
    @IBOutlet weak var ShareScreenLabel: UILabel!
    @IBOutlet weak var WifiBroadcast: UIImageView!

    static var CH_ID:String!
    static var BRStatus:Bool = false
  

    var agoraKit: AgoraRtcEngineKit!
    var location = CGPoint(x: 0, y: 0)
    var lockLocalViedeo = false
    
    var isRemoteVideoRender: Bool = true {
    
        
        didSet {

            remoteVideoMutedIndicator.isHidden = isRemoteVideoRender
            remoteVideo.isHidden = !isRemoteVideoRender     
            
        }
           
        
    }
    
    var isLocalVideoRender: Bool = false {
        didSet {
            localVideoMutedIndicator.isHidden = isLocalVideoRender
        }
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
       
      UIScreen.main.addObserver(self, forKeyPath: "captured", options: .new, context: nil)
             ClassroomLabel.text = VideoChatViewController.CH_ID
             initializeAgoraEngine()
            
            
            if VideoChatViewController.BRStatus == true {
               ShareScreenLabel.isHidden = false
               WifiBroadcast.isHidden = false
               agoraKit.disableVideo()
               joinChannel()
            }
            
            if VideoChatViewController.BRStatus == false {
                
 
                   ShareScreenLabel.isHidden = true
                   WifiBroadcast.isHidden = true
                   agoraKit.enableVideo()
                   setupVideo()
                   setupLocalVideo()
                   joinChannel()
                   let defaults = UserDefaults(suiteName: "group.com.apiphoom.Alfie-1.API")
                   defaults?.set(VideoChatViewController.CH_ID, forKey: "API")
                   
                   if #available(iOS 12.0, *) {
                       let broadcastPicker = RPSystemBroadcastPickerView(frame: CGRect(x: 5, y: 5, width: 40, height: 40))
                        broadcastPicker.preferredExtension = "com.apiphoom.Alfie2.Broadcast"
                    
                       ShareScreen.addSubview(broadcastPicker)
                    
                    
                    
                    
                       
                   } else {
                       // Fallback on earlier versions
                   }
            }
         
         
     }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if (keyPath == "captured"){
            let isCaptured = UIScreen.main.isCaptured
            print("Screen Broadcast status", isCaptured)
            VideoChatViewController.BRStatus = isCaptured
            print(VideoChatViewController.BRStatus)
            
            
            
            if VideoChatViewController.BRStatus == true {
                ShareScreenLabel.isHidden = false
                WifiBroadcast.isHidden = false
               
                
                          agoraKit.disableVideo()
                          isRemoteVideoRender = false
                          isLocalVideoRender = false
                          localVideo.isHidden = true
                          remoteVideo.isHidden = true
                          remoteVideoMutedIndicator.isHidden = true
                          localVideoMutedIndicator.isHidden = true
              
                       
                               
                                  
                              
                
              
            }
            if VideoChatViewController.BRStatus == false {
                
          
      
                          ShareScreenLabel.isHidden = true
                          WifiBroadcast.isHidden = true
                          agoraKit.enableVideo()
                          isRemoteVideoRender = true
                          isLocalVideoRender = true
                          localVideo.isHidden = false
                          remoteVideo.isHidden = false
                          remoteVideoMutedIndicator.isHidden = false
                          localVideoMutedIndicator.isHidden = false
                
                
               
             
            }
            
       
            
        }
    }
    
    @IBAction func blocksharescreen(_ sender: Any) {
        
        let alert = UIAlertController(title: "There was a problem", message: "To reduce the occurrence of screen sharing errors, please wait 20 seconds", preferredStyle: .alert)
                                  let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                                  alert.addAction(okButton)
                                  self.present(alert, animated: true, completion: nil)
                     print("BLOCK")
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     guard segue.identifier != nil else {
                return
            }
            
    }
    
    func initializeAgoraEngine() {
        // init AgoraRtcEngineKit
        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: KeyCenter.AppId, delegate: self)
    }

    func setupVideo() {
     
        agoraKit.enableVideo()
        agoraKit.setVideoEncoderConfiguration(AgoraVideoEncoderConfiguration(size: AgoraVideoDimension640x360,
                                                                             frameRate: .fps15,
                                                                             bitrate: AgoraVideoBitrateStandard,
                                                                             orientationMode: .adaptative))
    }
    
    func setupLocalVideo() {
 
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = 0
        videoCanvas.view = localVideo
        videoCanvas.renderMode = .hidden
        agoraKit.setupLocalVideo(videoCanvas)
    }
    
    func joinChannel() {
 
        // Set audio route to speaker
        agoraKit.setDefaultAudioRouteToSpeakerphone(true)
        agoraKit.joinChannel(byToken: KeyCenter.Token, channelId: VideoChatViewController.CH_ID, info: nil, uid: 0) { [unowned self] (channel, uid, elapsed) -> Void in
            // Did join channel "CH_ID"
            self.isLocalVideoRender = true
            
            
        }
       
      
    }
    
    func leaveChannel() {
        // leave channel and end chat
        agoraKit.leaveChannel(nil)
        isRemoteVideoRender = false
        isLocalVideoRender = false
 
        
        
    }
    
    

    
 
    
    
    
    
    @IBAction func didClickHangUpButton(_ sender: UIButton) {
      
            
            if VideoChatViewController.BRStatus == true {
                let alert = UIAlertController(title: "There was a problem", message: "Please stop sharing the screen before leaving the class.", preferredStyle: .alert)
                               let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                               alert.addAction(okButton)
                               self.present(alert, animated: true, completion: nil)
            }
            if VideoChatViewController.BRStatus == false{
                leaveChannel()
                performSegue(withIdentifier: "LeaveChannel", sender: self)
            }
            
            
            
    
    
        
        
    }

    
    @IBAction func didClickMuteButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        // mute local audio
        agoraKit.muteLocalAudioStream(sender.isSelected)
    }
    
    @IBAction func didClickSwitchCameraButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        agoraKit.switchCamera()
    }
    

    

    
    
}

extension VideoChatViewController: AgoraRtcEngineDelegate {
    
    
    
   
    func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid:UInt, size:CGSize, elapsed:Int) {
        isRemoteVideoRender = true
      
        // Only one remote video view is available for this
        // tutorial. Here we check if there exists a surface
        // view tagged as this uid.
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.view = remoteVideo
        videoCanvas.renderMode = .hidden
        agoraKit.setupRemoteVideo(videoCanvas)
        
    }
    
    /// Occurs when a remote user (Communication)/host (Live Broadcast) leaves a channel.
    /// - Parameters:
    ///   - engine: RTC engine instance
    ///   - uid: ID of the user or host who leaves a channel or goes offline.
    ///   - reason: Reason why the user goes offline
    func rtcEngine(_ engine: AgoraRtcEngineKit, didOfflineOfUid uid:UInt, reason:AgoraUserOfflineReason) {

    }
    
    /// Occurs when a remote user’s video stream playback pauses/resumes.
    /// - Parameters:
    ///   - engine: RTC engine instance
    ///   - muted: YES for paused, NO for resumed.
    ///   - byUid: User ID of the remote user.
    func rtcEngine(_ engine: AgoraRtcEngineKit, didVideoMuted muted:Bool, byUid:UInt) {
        isRemoteVideoRender = !muted
    }
    
    /// Reports a warning during SDK runtime.
    /// - Parameters:
    ///   - engine: RTC engine instance
    ///   - warningCode: Warning code
    func rtcEngine(_ engine: AgoraRtcEngineKit, didOccurWarning warningCode: AgoraWarningCode) {
       
    }
    
    /// Reports an error during SDK runtime.
    /// - Parameters:
    ///   - engine: RTC engine instance
    ///   - errorCode: Error code
    func rtcEngine(_ engine: AgoraRtcEngineKit, didOccurError errorCode: AgoraErrorCode) {
    }
    

    

    
}




