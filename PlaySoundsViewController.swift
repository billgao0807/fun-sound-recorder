
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
    
  }
  
  func setRate(rate: Float) {
    audioPlayer.stop()
    audioPlayer.currentTime = 0
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
