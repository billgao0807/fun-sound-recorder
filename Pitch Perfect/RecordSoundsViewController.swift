//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Zhongyang Gao on 1/12/16.
//  Copyright © 2016 Zhongyang Gao. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
  
  @IBOutlet weak var recordingLabel: UILabel!
  @IBOutlet weak var recordButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!
  
  var audioRecorder:AVAudioRecorder!
  var recordedAudio:RecordedAudio!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(animated: Bool) {
    recordButton.enabled = true;
    stopButton.hidden = true;
    recordingLabel.hidden = true;
  }
  
  @IBAction func recordButton(sender: UIButton) {
    stopButton.hidden = false;
    recordingLabel.hidden = false;
    recordButton.enabled = false;
    
    let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
    
    //    let currentDateTime = NSDate()
    //    let formatter = NSDateFormatter()
    //    formatter.dateFormat = "ddMMyyyy-HHmmss"
    let recordingName = "tempRecodring"+".wav"
    
    let pathArray = [dirPath, recordingName]
    let filePath = NSURL.fileURLWithPathComponents(pathArray)
    print(filePath)
    
    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
    
    try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
    audioRecorder.delegate = self
    audioRecorder.meteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
  }
  
  func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
    
    if(flag){
      recordedAudio = RecordedAudio()
      recordedAudio.filePathUrl = recorder.url
      recordedAudio.title = recorder.url.lastPathComponent
      
      self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
    } else {
      print("Recording was not seccessful")
      recordButton.enabled = true;
      stopButton.hidden = true;
      recordingLabel.hidden = true;
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "stopRecording") {
      let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
      let data = sender as! RecordedAudio
      playSoundsVC.receivedAudio = data
    }
    
  }
  
  @IBAction func stopButton(sender: UIButton) {
    recordingLabel.hidden = true;
    audioRecorder.stop()
    let audioSession = AVAudioSession.sharedInstance()
    try! audioSession.setActive(false)
  }
  
}

