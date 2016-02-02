
//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Zhongyang Gao on 1/13/16.
//  Copyright © 2016 Zhongyang Gao. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
  
  var audioPlayer:AVAudioPlayer!
  var receivedAudio:RecordedAudio!
  
  //Declared globally within PlaySoundsViewController
  var audioEngine:AVAudioEngine!
  var audioFile:AVAudioFile!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //    if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
    //      let filePathUrl = NSURL.fileURLWithPath(filePath)
    //      audioPlayer = try!
    //        AVAudioPlayer(contentsOfURL: filePathUrl)
    //      audioPlayer.enableRate = true
    //
    //    } else {
    //      print("file path incorrect")
    //    }
    audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
    audioPlayer.enableRate = true
    
    audioEngine = AVAudioEngine()
    audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    
  }
  
  func setRate(rate: Float) {
    audioPlayer.stop()
    audioPlayer.rate = rate
    audioPlayer.play()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func playSlowly(sender: UIButton) {
    setRate(0.5)
  }
  
  @IBAction func playFast(sender: UIButton) {
    setRate(1.5)
    
  }
  
  @IBAction func stopPlayer(sender: UIButton) {
    audioPlayer.stop()
    audioPlayer.currentTime = 0
  }
  
  @IBAction func playChipmunkAudio(sender: UIButton) {
    playAudioWithVariablePitch(1000)
  }
  
  @IBAction func playDarthvaderAudio(sender: UIButton) {
    playAudioWithVariablePitch(-1000)
  }
  func playAudioWithVariablePitch(pitch: Float){
    audioPlayer.stop()
    audioEngine.stop()
    audioEngine.reset()
    
    let audioPlayerNode = AVAudioPlayerNode()
    audioEngine.attachNode(audioPlayerNode)
    
    let changePitchEffect = AVAudioUnitTimePitch()
    changePitchEffect.pitch = pitch
    audioEngine.attachNode(changePitchEffect)
    
    audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
    audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
    
    audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
    try! audioEngine.start()
    
    audioPlayerNode.play()
  }
  
  /*
  // MARK: - Navigation
  

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
