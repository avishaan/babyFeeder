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
  
  // 206	104	107
  let kActiveStateColor = UIColor(red: 206/255, green: 104/255, blue: 107/255, alpha: 1.0)
  // 95	95	96	 // this should be the default grey
  let kPassiveStateColor = UIColor(red: 95/255, green: 95/255, blue: 96/255, alpha: 1.0)
  // color that designates the last button that was last pressed
  let kLastStateColor = UIColor(red: 206/255, green: 104/255, blue: 107/255, alpha: 0.5)
  
  var lastFeedDate = NSDate()
  var lastFeedDuration = LastDuration()
  
  
  @IBOutlet weak var leftTimerInterface: WKInterfaceTimer!
  @IBOutlet weak var rightTimerInterface: WKInterfaceTimer!
  @IBOutlet weak var totalTimerInterface: WKInterfaceTimer!
  @IBOutlet weak var leftButton: WKInterfaceButton!
  @IBOutlet weak var rightButton: WKInterfaceButton!
  @IBOutlet weak var lastFeedDateLabel: WKInterfaceLabel!
  
  var leftTimer:Timer = Timer()
  var rightTimer:Timer = Timer()
  var totalTimer:Timer = Timer()
  // keep track of which button is active
  var buttonState = (left: false, right: false)
  var lastButtonState:(left:Bool, right:Bool)!
  
  var tripleTimer:ToggleTimer = ToggleTimer()
  
  var userDefaults = NSUserDefaults.standardUserDefaults()
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    lastButtonState =  self.restoreState()
    showLastUsedButton(lastButtonState)
    
    // restore the last feedDate
    lastFeedDate = restoreLastFeedDate()
    lastFeedDuration = restoreLastFeedDuration()
    updateLastFeedDateLabel(lastFeedDate, lastFeedDuration: lastFeedDuration)
    
    tripleTimer.restoreState()
    
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // save the state of the buttons
    self.persistState(lastButtonState)
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  @IBAction func onRightButtonTap() {
    
    tripleTimer.trigger(.Right)
    // update button color states and the timer label
    updateButtonColor(tripleTimer)
    updateTimerInterface(tripleTimer)
//    
//    // check on the left button
//    if buttonState.left {
//      // no matter what, disable the left button if it is enabled
//      buttonState.left = false
//      // since the left button was just on, set as last button
//      lastButtonState = (true, false)
//      stopTimer(leftTimerInterface, timer: leftTimer)
//    }
//    // update the right button based on it's current state
//    if buttonState.right {
//      // if right button is enabled, disable and stop timer and set as last button
//      buttonState.right = false
//      // this button was last pressed, set right button lastButtonState to remember this and set left to false
//      lastButtonState = (false, true)
//      // update the timer interface and model
//      stopTimer(rightTimerInterface, timer: rightTimer)
//      
//    } else {
//      // if right button is disabled, enable and start timer and remove last button set on the left
//      buttonState.right = true
//      // update the timer interface and model
//      startTimer(rightTimerInterface, timer: rightTimer)
//    }
//    
//    //visually update button states
//    updateButtonStates()
//    
//    // manage the top timer which stays on if either left/right button is in the on state
//    // if either button is on, make sure the timer is on
//    println("left: \(buttonState.left) right: \(buttonState.right) isTotalOn: \(totalTimer.on!)")
//    if buttonState.left || buttonState.right {
//      // only start timer if it is currently off
//      if !totalTimer.on! {
//        startTimer(totalTimerInterface, timer: totalTimer)
//      } else {
//        // the timer is already on and should be on, leave it alone
//      }
//    } else {
//      // if both buttons are off, turn off top timer
//      stopTimer(totalTimerInterface, timer: totalTimer)
//    }
  }
  
  @IBAction func onLeftButtonTap() {
    
    tripleTimer.trigger(.Left)
    // update button color states and the timer label
    updateButtonColor(tripleTimer)
    updateTimerInterface(tripleTimer)
//    // check the right button
//    if buttonState.right {
//      // if its on, turn it off
//      buttonState.right = false
//      // set this as the last button
//      lastButtonState = (false, true)
//      stopTimer(rightTimerInterface, timer: rightTimer)
//    }
//    // check this, left button if it's on
//    if buttonState.left {
//      // disable left button
//      buttonState.left = false
//      lastButtonState = (true, false)
//      stopTimer(leftTimerInterface, timer: leftTimer)
//    } else {
//      // enable left button
//      buttonState.left = true
//      startTimer(leftTimerInterface, timer: leftTimer)
//    }
//    // visually update button states
//    updateButtonStates()
//    // manage the top timer which stays on if either left/right button is in the on state
//    // if either button is on, make sure the timer is on
//    println("left: \(buttonState.left) right: \(buttonState.right) isTotalOn: \(totalTimer.on!)")
//    if buttonState.left || buttonState.right {
//      // only start timer if it is currently off
//      if !totalTimer.on! {
//        startTimer(totalTimerInterface, timer: totalTimer)
//      } else {
//        // the timer is already on and should be, leave it alone
//      }
//    } else {
//      // if both buttons are off, turn off top timer
//      stopTimer(totalTimerInterface, timer: totalTimer)
//    }
  }
  @IBAction func onNewButtonTap() {
    tripleTimer.reset()
    // reset data in the timer models
    rightTimer.reset()
    leftTimer.reset()
    
    // reset the timerInterface
    rightTimerInterface.stop()
    // set to current date to zero it out
    rightTimerInterface.setDate(NSDate())
    
    leftTimerInterface.stop()
    // set to current date to zero it out
    leftTimerInterface.setDate(NSDate())
    
//    // pick the correct last button state based on currently active button
//    if buttonState.left {
//      lastButtonState = (true, false)
//    }
//    if buttonState.right {
//      lastButtonState = (false, true)
//    }
//    
//    // reset the active button state
//    buttonState = (false, false)
//    
    
    totalTimer.stop()
    // set the lastDuration to the total timer so it says your last duration
    lastFeedDuration.interval = totalTimer.timeElapsed
    
    
    updateButtonColor(tripleTimer)
//    // update with the last button state since there should be nothing active at this point
//    updateButtonStates()
//    
    updateLastFeedDateLabel(NSDate(), lastFeedDuration: lastFeedDuration)
    
    // stop top timer and reset it
    totalTimer.reset()
    //reset the timer interface
    totalTimerInterface.stop()
    // set to current date to zero it out
    totalTimerInterface.setDate(NSDate())
  }
  
  func updateTimerInterface(timer:ToggleTimer) {
    // stop all the timers to get to a consistent state
    leftTimerInterface.stop()
    rightTimerInterface.stop()
    totalTimerInterface.stop()
    
    // start the timer interface countdown
    switch timer.currentOn {
    case .Left:
      leftTimerInterface.start()
      // make sure the timer interface has the right info on it
      leftTimerInterface.setDate(timer.timers.left.date)
      totalTimerInterface.start()
      totalTimerInterface.setDate(timer.timers.total.date)
    case .Right:
      rightTimerInterface.start()
      rightTimerInterface.setDate(timer.timers.right.date)
      totalTimerInterface.start()
      totalTimerInterface.setDate(timer.timers.total.date)
    case .None:
      println("No timers on")
    }

  }
  func updateButtonColor(timer:ToggleTimer) {
    // first, reset all button to their passive state color
    leftButton.setBackgroundColor(kPassiveStateColor)
    rightButton.setBackgroundColor(kPassiveStateColor)
    // put all timerInterfaces into their stopped state
    leftTimerInterface.stop()
    rightTimerInterface.stop()
    
    
    // the button currently on gets the active state color
    switch timer.currentOn {
    case .Left:
      leftButton.setBackgroundColor(kActiveStateColor)
      leftTimerInterface.start()
    case .Right:
      rightButton.setBackgroundColor(kActiveStateColor)
      rightTimerInterface.start()
    case .None:
      println("No button is on, we are completely paused")
    }
    
    // button that was last on gets the last state color
    switch timer.lastOn {
    case .Left:
      leftButton.setBackgroundColor(kLastStateColor)
    case .Right:
      rightButton.setBackgroundColor(kLastStateColor)
    case .None:
      println("no button was last on, this shouldn't happen")
    }
  }
  func updateButtonStates(){
    let entireState = (buttonState.left, lastButtonState.left, buttonState.right, lastButtonState.right)
    // set all buttons to default color first
    leftButton.setBackgroundColor(kPassiveStateColor)
    rightButton.setBackgroundColor(kPassiveStateColor)
    switch entireState {
    case (false, false, false, false):
      // nothing is on
      break;
    case (true, false, false, true):
      // left button active, right button was last
      leftButton.setBackgroundColor(kActiveStateColor)
      rightButton.setBackgroundColor(kLastStateColor)
    case (false, true, true, false):
      // left button in last state, right button active
      leftButton.setBackgroundColor(kLastStateColor)
      rightButton.setBackgroundColor(kActiveStateColor)
    case (false, true, false, false):
      // nothing active, left side was last
      leftButton.setBackgroundColor(kLastStateColor)
    case (false, false, false, true):
      // nothing active, right side was last
      rightButton.setBackgroundColor(kLastStateColor)
    case (true, true, false, false), (true, false, false, false):
      // if the left button is either both active and last or just active set left button as active
      leftButton.setBackgroundColor(kActiveStateColor)
    case (false, false, true, true), (false, false, true, false):
      // if the right button is either both active and last or just active set right button as active
      rightButton.setBackgroundColor(kActiveStateColor)
    default:
      println("ERROR, should not be in this state")
    }
    
  }
  // func checks the button states and update them with the correct color
  // TODO remove use of this function
  func showCurrentButtonState(buttonState:(left:Bool, right:Bool)) {
    if buttonState.left {
      leftButton.setBackgroundColor(kActiveStateColor)
//      leftButton.setBackgroundColor(UIColor.clearColor())
//      leftButton.setBackgroundImageNamed("animation")
    } else {
//      leftButton.setBackgroundColor(kPassiveStateColor)
    }
    if buttonState.right {
      rightButton.setBackgroundColor(kActiveStateColor)
//      rightButton.setBackgroundColor(UIColor.clearColor())
//      rightButton.setBackgroundImageNamed("animation")
    } else {
//      rightButton.setBackgroundColor(kPassiveStateColor)
    }
  }
  
  func showLastUsedButton(lastButtonState:(left:Bool, right:Bool)) {
    // see if any of the last button states are on, if they are go ahead and make the interface reflect that
    if lastButtonState.left {
      leftButton.setBackgroundColor(kLastStateColor)
    } else {
//      leftButton.setBackgroundColor(kPassiveStateColor)
    }
    if lastButtonState.right {
      rightButton.setBackgroundColor(kLastStateColor)
    } else {
//      rightButton.setBackgroundColor(kPassiveStateColor)
    }
  }
  
  // update the last feed date label with lastFeedDate as the date to set the date label to
  func updateLastFeedDateLabel(lastFeedDate:NSDate, lastFeedDuration:LastDuration) {
    // set now as our last feed
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    let lastFeedDateString = dateFormatter.stringFromDate(lastFeedDate)
    
    // combine the last feed date with the last feed duration
    lastFeedDateLabel.setText(lastFeedDateString + " for " + lastFeedDuration.text)
    // save date into persistance
    persistLastFeedDate(lastFeedDate)
    persistLastFeedDuration(lastFeedDuration.interval)
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
  
  func restoreLastFeedDuration() -> LastDuration {
    println("restore last feed duration")
    let lastFeed = userDefaults.objectForKey("lastFeedDuration") as? Double
    if lastFeed == nil {
      // if last feed is nil, it's our first time accessing it and set it to now
      return LastDuration()
    } else {
      // return the retreived value
      return LastDuration(startDuration: lastFeed!)
    }
  }
  
  func persistLastFeedDuration(lastFeedDuration:Double) {
    println("saving last feed duration")
    userDefaults.setObject(lastFeedDuration, forKey: "lastFeedDuration")
  }
  
  func persistLastFeedDate(lastFeedDate:NSDate) {
    println("saving last feed date")
    userDefaults.setObject(lastFeedDate, forKey: "lastFeedDate")
  }
  
  func restoreLastFeedDate() -> NSDate {
    let lastFeed = userDefaults.objectForKey("lastFeedDate") as? NSDate
    if lastFeed == nil {
      // if last feed is nil, it's our first time accessing it and set it to now
      return NSDate()
    } else {
      // return the retreived value
      return lastFeed!
    }
  }
  
  func persistState(state:(left:Bool, right:Bool)) {
    println("persist the state of the timers")
    // save state of left button
    userDefaults.setObject(state.left, forKey: "buttonStateLeft")
    // save state of right button
    userDefaults.setObject(state.right, forKey: "buttonStateRight")
  }
  
  func restoreState() -> (left:Bool, right:Bool) {
    // object for key will return nil when unset vs boolForKey which will return false
    let leftState = userDefaults.objectForKey("buttonStateLeft") as? Bool
    let rightState = userDefaults.objectForKey("buttonStateRight") as? Bool
    // if the value is nil, this is our first time accessing it, set everything to false
    if leftState == nil || rightState == nil {
      println("first time, will be nil")
      return (false, false);
    } else {
      // use the values in the userDefaults
      println("we already have values")
      return (leftState!, rightState!)
    }
  }
}
