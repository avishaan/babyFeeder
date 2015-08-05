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
    // check on the left button
    if buttonState.left {
      // no matter what, disable the left button if it is enabled
      buttonState.left = false
      leftButton.setBackgroundColor(UIColor.darkGrayColor())
      stopTimer(leftTimerInterface, timer: leftTimer)
    }
    // update the right button based on it's current state
    if buttonState.right {
      // if right button is enabled, disable and stop timer and set as last button
      buttonState.right = false
      rightButton.setBackgroundColor(UIColor.orangeColor())
      // update the timer interface and model
      stopTimer(rightTimerInterface, timer: rightTimer)
    } else {
      // if right button is disabled, enable and start timer and remove last button set on the left
      buttonState.right = true
      rightButton.setBackgroundColor(UIColor.greenColor())
      // the left button may have been the last one but it won't be anymore
      leftButton.setBackgroundColor(UIColor.darkGrayColor())
      // update the timer interface and model
      startTimer(rightTimerInterface, timer: rightTimer)
    }
  }
  
  @IBAction func onLeftButtonTap() {
    // check the right button
    if buttonState.right {
      // if its on, turn it off
      buttonState.right = false
      rightButton.setBackgroundColor(UIColor.darkGrayColor())
      stopTimer(rightTimerInterface, timer: rightTimer)
    }
    // check this, left button if it's on
    if buttonState.left {
      // disable left button
      buttonState.left = false
      leftButton.setBackgroundColor(UIColor.orangeColor())
      stopTimer(leftTimerInterface, timer: leftTimer)
    } else {
      // enable left button
      buttonState.left = true
      leftButton.setBackgroundColor(UIColor.greenColor())
      rightButton.setBackgroundColor(UIColor.darkGrayColor())
      startTimer(leftTimerInterface, timer: leftTimer)
    }
  }
  @IBAction func onNewButtonTap() {
    // reset data in the timer models
    rightTimer.reset()
    leftTimer.reset()
    
    // reset the timerInterface
    rightTimerInterface.stop()
    rightTimerInterface.setDate(NSDate())
    
    leftTimerInterface.stop()
    leftTimerInterface.setDate(NSDate())
    
    // reset the button colors
    rightButton.setBackgroundColor(UIColor.darkGrayColor())
    leftButton.setBackgroundColor(UIColor.darkGrayColor())
    
    // reset the button state
    buttonState = (false, false)
    
  }
  
  func startTimer(timerInterface:WKInterfaceTimer, timer:Timer) {
    // make sure the timer interface has the right info on it
    timerInterface.setDate(timer.date)
    // start the timer interface counting
    timerInterface.start()
    // start the timer model counting
    timer.start()
  }
  
  func stopTimer(timerInterface:WKInterfaceTimer, timer:Timer) {
    // pause the timer label
    timerInterface.stop()
    // pause the timer model counting
    timer.stop()
  }
}
