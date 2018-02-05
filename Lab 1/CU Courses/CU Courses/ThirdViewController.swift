//
//  ThirdViewController.swift
//  CU Courses
//
//  Created by Mahmoud Aljarrash on 1/29/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit
import AVFoundation

class ThirdViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate{

    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    let fileName = "audio.m4a"
    let audioSession = AVAudioSession.sharedInstance()
    
    var timer = Timer()
    var seconds = 0
    var isTimerRunning = false
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func playBtnClicked(_ sender: UIButton)
    {
        //if not recording play audio file
        if audioRecorder?.isRecording == false
        {
            stopBtn.isEnabled = true
            recordBtn.isEnabled = false
            pauseBtn.isHidden = false
            playBtn.isHidden = true
           // pauseBtn.setTitle("pause-0", for: .normal)
            //pauseBtn.setTitle("Pause", for: .normal)
            pauseBtn.imageView?.image = UIImage(named: "pause")

            do
            {
                seconds = 0
                runTimer()
                //change the session cat based on the operation to overcome the low-volume issue
                self.setSessionCategoryToPlayback()
                
                try audioPlayer = AVAudioPlayer(contentsOf:(audioRecorder?.url)!)
                audioPlayer!.delegate = self
                //audioPlayer!.prepareToPlay()//prepares the audio player for playback by preloading its buffers
                audioPlayer!.play() //plays audio file
                
                Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgressBar), userInfo: nil, repeats: true)
                progressBar.setProgress(Float(audioPlayer!.currentTime/audioPlayer!.duration), animated: false)
                
            } catch let error
            {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func pauseBtnClicked(_ sender: UIButton)
    {
        stopBtn.isEnabled = true
        recordBtn.isEnabled = false
        
        if audioPlayer!.isPlaying
        {
            //pasuse the timer
            timer.invalidate()
            
            print("pausing...")
            audioPlayer!.pause()
            //pauseBtn.setTitle("Play", for: .normal)
            pauseBtn.setImage(UIImage(named: "play"), for: .normal)

        }
        else
        {
            //resume the timer
            runTimer()
            print("playing after pause...")

            audioPlayer!.play()
            //pauseBtn.setTitle("Pause", for: .normal)
            pauseBtn.setImage(UIImage(named: "pause"), for: .normal)

        }
    }
    
    @IBAction func stopBtnClicked(_ sender: UIButton)
    {
        //stop the timer
        timer.invalidate()
        
        stopBtn.isEnabled = false
        playBtn.isEnabled = true
        recordBtn.isEnabled = true
        pauseBtn.isEnabled = true
        
        playBtn.isHidden = false
        pauseBtn.isHidden = true
        //stop recording or playing
        if audioRecorder?.isRecording == true
        {
            audioRecorder?.stop()
        } else
        {
            audioPlayer?.stop()
        }
    }
    @IBAction func recordBtnClicked(_ sender: Any)
    {
        //if not already recording, start recording
        if audioRecorder?.isRecording == false
        {
            self.setSessionCategoryToRecord()
            
            //reset the timer and start counting
            seconds = 0
            runTimer()
            
            playBtn.isEnabled = false
            stopBtn.isEnabled = true
            pauseBtn.isEnabled = false
            
            playBtn.isHidden = false
            pauseBtn.isHidden = true

            audioRecorder?.delegate = self
            print("start recoding")
            audioRecorder?.record()
            
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateRecordingProgressBar), userInfo: nil, repeats: true)
            //progressBar.setProgress(Float(audioRecorder!.currentTime/60), animated: false)
            
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        pauseBtn.isHidden = true
        playBtn.isHidden = false
        
        stopBtn.isEnabled = false
        recordBtn.isEnabled = true
        
        //pauseBtn.setTitle("Pause", for: .normal)
        pauseBtn.setImage(UIImage(named: "pause"), for: .normal)
        progressBar.setProgress(0.0, animated: false)
        
        //pause the timer
        timer.invalidate()
    }
    
    func setSessionCategoryToPlayback()
    {
        do
        {
        try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        try audioSession.setActive(false)
        print("Session category set to AVAudioSessionCategoryPlayback ")

        }
        catch let error
        {
            print("audioPlayer error: \(error.localizedDescription)")
        }
    }
    
    func setSessionCategoryToRecord()
    {
        do
        {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setActive(false)
            print("Session category set to AVAudioSessionCategoryRecord ")

        }
        catch let error
        {
            print("audioPlayer error: \(error.localizedDescription)")
        }
    }
    
    @objc func updateDurationLabel()
    {
        seconds += 1     //This will decrement(count down)the seconds.
        durationLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    func runTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:(#selector(ThirdViewController.updateDurationLabel)), userInfo: nil, repeats: true)
    }
    
    func timeString(time: TimeInterval) -> String
    {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02i:%02i", minutes,seconds)
    }
    
    @objc func updateProgressBar()
    {
        if audioPlayer!.isPlaying
        {
            progressBar.setProgress(Float(audioPlayer!.currentTime/audioPlayer!.duration), animated: true)
        }
    }
    
    @objc func updateRecordingProgressBar()
    {
        if audioRecorder!.isRecording
        {
            
            progressBar.setProgress(Float(audioRecorder!.currentTime/120), animated: true)
        }
   
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        stopBtn.isEnabled = false
        playBtn.isEnabled = false
        pauseBtn.isHidden = true
        progressBar.setProgress(0.0, animated: false)
        
        //recordBtn.imageView?.contentMode = .center
        
        //get path for the audio file
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0] //documents directory
        let audioFileURL = docDir.appendingPathComponent(fileName)
        print(audioFileURL)

        do
        {
            //sets he category for recording and playback of audio
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch
        {
            print("audio session error: \(error.localizedDescription)")
        }
        //recorder settings
        let settings =
        [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC), //specifies audio codec
            AVSampleRateKey: 12000, //sample rate in hertz
            AVNumberOfChannelsKey: 1, //number of channels
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue //audio bit rate
        ]
        do
        {
            //create the AVAudioRecorder instance
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
            audioRecorder?.prepareToRecord()
            print("audio recorder ready")
        } catch
        {
            print("audio recorder error: \(error.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
