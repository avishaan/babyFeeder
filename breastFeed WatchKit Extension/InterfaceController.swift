//
//  InterfaceController.swift
//  breastFeed WatchKit Extension
//
//  Created by Brown Magic on 8/4/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
  
  @IBOutlet weak var leftTimerInterface: WKInterfaceTimer!
  @IBOutlet weak var rightTimerInterface: WKInterfaceTimer!
  @IBOutlet weak var totalTimer: WKInterfaceTimer!
  @IBOutlet weak var leftButton: WKInterfaceButton!
  @IBOutlet weak var rightButton: WKInterfaceButton!
  
  var leftTimer:Timer = Timer()
  var rightTimer:Timer = Timer()
  
  // keep track of how much time has elapsed on each
  var timeElapsed:(left: Double, right: Double) = (0.0, 0.0)
  
  // keep track of the date when the timer was started so we know the elapsed time
  var timeStarted:(left: NSDate, right: NSDate)?
  
  // keep track of which button is active
  var buttonState = (left: false, right: false)
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  @IBAction func onRightButtonTap() {
    // is the left button on
    if buttonState.left {
      // no matter what, disable the left button if it is enabled
      buttonState.left = false
      leftButton.setBackgroundColor(UIColor.clearColor())
    }
    // is this, the right button, on?
    if buttonState.right {
      // if right button is enabled, disable
      buttonState.right = false
      rightButton.setBackgroundColor(UIColor.clearColor())
    } else {
      // if right button is disabled, enable
      buttonState.right = true
      rightButton.setBackgroundColor(UIColor.greenColor())
      
    }
    // make sure the correct timers are on
    self.startTimers(buttonState)
  }
  
  @IBAction func onLeftButtonTap() {
    // check the right button
    if buttonState.right {
      // if its on, turn it off
      buttonState.right = false
      rightButton.setBackgroundColor(UIColor.clearColor())
    }
    // check this, left button if it's on
    if buttonState.left {
      // disable left button
      buttonState.left = false
      leftButton.setBackgroundColor(UIColor.clearColor())
    } else {
      // enable left button
      buttonState.left = true
      leftButton.setBackgroundColor(UIColor.greenColor())
    }
    // make sure the correct timers are on
    self.startTimers(buttonState)
  }
  
  func startTimers(buttonState: (left: Bool, right: Bool)) {
    // check left button state
    if buttonState.left {
      // update the timerInterface with the correct date
      leftTimerInterface.setDate(leftTimer.date)
      leftTimer.start()
      // start timer
      leftTimerInterface.start()
    } else {
      // stop timer
      leftTimer.stop()
      leftTimerInterface.stop()
    }
    // check right button state
    if buttonState.right {
      // set the correct time on the interface
      rightTimerInterface.setDate(rightTimer.date)
      rightTimer.start()
      // start timer
      rightTimerInterface.start()
    } else {
      // stop timer
      rightTimer.stop()
      rightTimerInterface.stop()
    }
  }
}
