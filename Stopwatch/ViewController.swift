//
//  ViewController.swift
//  Stopwatch
//
//  Created by Vittorio Morganti on 21/01/16.
//  Copyright © 2016 toioski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bigTimerLabel: UILabel!
    @IBOutlet weak var smallTimerLabel: UILabel!
    @IBOutlet weak var startButton: DesignableButton!
    @IBOutlet weak var resetButton: DesignableButton!
    @IBOutlet weak var lapTableView: UITableView!
    @IBOutlet weak var tableContainerView: DesignableView!
    
    var startDate: NSDate?
    var stopTimer: NSTimer = NSTimer()
    var isRunning = false
    var pauseDate: NSDate?
    var laps: [String] = []
    var lapDate: NSDate?
    
    var red: UIColor = UIColor(red:0.9, green:0.23, blue:0.18, alpha:1)
    var green: UIColor = UIColor(red:0.51, green:0.92, blue:0.2, alpha:1)
    var disableGreyBackColor: UIColor = UIColor(red:0.894, green:0.894, blue:0.894, alpha:1)
    var disableTextColor: UIColor = UIColor(red:0.534, green:0.534, blue:0.534, alpha:1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting monospace font is necessary, otherwise label 
        //will start "shrinking" when its label will be updated by the NSTimer
        bigTimerLabel.font = UIFont.monospacedDigitSystemFontOfSize(68, weight: UIFontWeightUltraLight)
        smallTimerLabel.font = UIFont.monospacedDigitSystemFontOfSize(24, weight: UIFontWeightUltraLight)
        
        bigTimerLabel.text = "00:00,00"
        smallTimerLabel.text = "00:00,00"
        
        //Button configs
        startButton.clipsToBounds = true
        resetButton.clipsToBounds = true
        startButton.setBackgroundImage(UIImage.imageWithColor(UIColor.grayColor()), forState: .Highlighted)
        resetButton.setBackgroundImage(UIImage.imageWithColor(UIColor.grayColor()), forState: .Highlighted)
        resetButton.setBackgroundImage(UIImage.imageWithColor(disableGreyBackColor), forState: .Disabled)
        resetButton.setTitleColor(disableTextColor, forState: .Disabled)
        resetButton.enabled = false
        
    }
    
    //This function is triggered when the device change orientation
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        if UIView.viewOrientationForSize(size) == ViewOrientation.Landscape {
            bigTimerLabel.font = UIFont.monospacedDigitSystemFontOfSize(54, weight: UIFontWeightUltraLight)
            smallTimerLabel.font = UIFont.monospacedDigitSystemFontOfSize(20, weight: UIFontWeightUltraLight)
        } else {
            bigTimerLabel.font = UIFont.monospacedDigitSystemFontOfSize(68, weight: UIFontWeightUltraLight)
            smallTimerLabel.font = UIFont.monospacedDigitSystemFontOfSize(24, weight: UIFontWeightUltraLight)
        }
    }
    
    
    @IBAction func startTimer(sender: AnyObject) {
        if (!isRunning) {
            isRunning = true
            
            resetButton.enabled = true
            resetButton.setBackgroundImage(UIImage.imageWithColor(UIColor.whiteColor()), forState: .Normal)
            resetButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
            
            if (pauseDate != nil) {
                let secondsBetween = pauseDate!.timeIntervalSinceDate(startDate!)
                startDate = NSDate(timeIntervalSinceNow: (-1)*secondsBetween)
            } else {
                startDate = NSDate()
            }
            
            sender.setTitle("Stop", forState: .Normal)
            sender.setTitleColor(red, forState: .Normal)
            resetButton.setTitle("Giro", forState: .Normal)
            
            stopTimer = NSTimer.scheduledTimerWithTimeInterval(1.0/100.0, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
            //This line prevent the timer to stop when scrolling
            NSRunLoop.mainRunLoop().addTimer(stopTimer, forMode: NSRunLoopCommonModes)
        } else {
            isRunning = false
            sender.setTitle("Start", forState: .Normal)
            sender.setTitleColor(green, forState: .Normal)
            resetButton.setTitle("Reset", forState: .Normal)
            resetButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            resetButton.setBackgroundImage(UIImage.imageWithColor(red), forState: .Normal)
            stopTimer.invalidate()
            pauseDate = NSDate()
        }
    }
    
    //Business logic
    func updateTimer() {
        let currentDate = NSDate()
        let timeInterval = currentDate.timeIntervalSinceDate(startDate!)
        let timerDate = NSDate(timeIntervalSince1970: timeInterval)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "mm:ss,SS"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        let timeString = dateFormatter.stringFromDate(timerDate)
        bigTimerLabel.text = timeString
        
        if (lapDate != nil) {
            let anotherTimeInterval = currentDate.timeIntervalSinceDate(lapDate!)
            let lapTimerDate = NSDate(timeIntervalSince1970: anotherTimeInterval)
            let lapTimerString = dateFormatter.stringFromDate(lapTimerDate)
            smallTimerLabel.text = lapTimerString
        } else {
            smallTimerLabel.text = timeString
        }
    }
    
    @IBAction func resetPressed(sender: AnyObject) {
        if (!isRunning) {
            //Reset all parameters
            
            stopTimer.invalidate()
            pauseDate = nil
            lapDate = nil
            bigTimerLabel.text = "00:00,00"
            smallTimerLabel.text = "00:00,00"
            startButton.setTitle("Start", forState: .Normal)
            startButton.setTitleColor(green, forState: .Normal)
            isRunning = false
            resetButton.enabled = false
            laps.removeAll()
            lapTableView.reloadData()
        } else {
            //Add lap
            
            lapDate = NSDate()
            laps.insert(bigTimerLabel.text!, atIndex: 0)
            lapTableView.reloadData()
        }

    }
    
    //TableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("LapCell") as! LapTableViewCell
        cell.backgroundColor = UIColor.clearColor()
        
        //La numerazione dei giri è inversa rispetto a quella delle righe della tabella
        let lapNumber = laps.count - indexPath.row
        cell.label!.text = "Giro \(lapNumber)"
        cell.time!.text = laps[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }

}

