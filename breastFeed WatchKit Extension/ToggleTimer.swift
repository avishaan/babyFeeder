//
//  DualToggleTimer.swift
//  breastFeed
//
//  Created by Brown Magic on 8/23/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation

class ToggleTimer {
  var timers:(left:Timer, right:Timer, total:Timer) = (Timer(),Timer(),Timer())
//  var state = [Side.Left, State.None]
  
  var lastOn:Side = .None
  var currentOn:Side = .None
  var userDefaults = NSUserDefaults.standardUserDefaults()
  
  enum State:String {
    case Active = "Active"
    case LastOn = "LastOn"
    case None = "None"
  }
  
  enum Side:String {
    case Left = "Left"
    case Right = "Right"
    case None = "None"
  }
  
  init() {
    // initialize the two timers
    timers.left = Timer()
    timers.right = Timer()
    timers.total = Timer()
    
    // TODO: restore state from previous state
  }
  
  func trigger(side:Side) {
    // store the currentOn as the one that was last on
    lastOn = currentOn
    // turn off all timers to get us in a consistent state
    timers.left.stop()
    timers.right.stop()
    timers.total.stop()
    // if the triggered side is the same as the currentOn side, then just pause the timers
    if side == currentOn {
      // set nothing as currentlyOn
      currentOn = .None
    } else {
      // set this side as current on
      currentOn = side
      // start the timer for this side
      switch side {
      case .Left:
        timers.left.start()
        timers.total.start()
      case .Right:
        timers.right.start()
        timers.total.start()
      default:
        println("This is an error")
      }
      
    }
    // save into persistance everytime the state is changed
    persistState()
    
  }
  
  func restoreState() {
    println("Restore State")
    // restore button state
    if let currentOn:String = userDefaults.objectForKey("currentOn") as? String {
      switch currentOn {
      case "Left":
        self.currentOn = .Left
        // since left was on, turn it on again
        timers.left.start()
        timers.total.start()
      case "Right":
        self.currentOn = .Right
        timers.right.start()
        timers.total.start()
      case "None":
        self.currentOn = .None
      default:
        println("we shouldn't have this as an option")
      }
    }
    if let lastOn:String = userDefaults.objectForKey("lastOn") as? String {
      switch lastOn {
      case "Left":
        self.lastOn = .Left
      case "Right":
        self.lastOn = .Right
      case "None":
        self.lastOn = .None
      default:
        println("we shouldn't have this as an option")
      }
    }
    
    // restore timer dates
    if let leftTimer = userDefaults.objectForKey("leftTimer") as? NSDate {
      timers.left.lastStart = leftTimer
    }
    if let rightTimer = userDefaults.objectForKey("rightTimer") as? NSDate {
      timers.right.lastStart = rightTimer
    }
    if let totalTimer = userDefaults.objectForKey("totalTimer") as? NSDate {
      timers.total.lastStart = totalTimer
      println("restoring total seconds: \(totalTimer) vs now: \(NSDate())")
    }
    
  }
  
  func persistState() {
    println("persist/store state")
    // save button on states
    userDefaults.setObject(currentOn.rawValue, forKey: "currentOn")
    // save last button state
    userDefaults.setObject(lastOn.rawValue, forKey: "lastOn")
    // save timer dates
    userDefaults.setObject(timers.left.lastStart, forKey: "leftTimer")
    userDefaults.setObject(timers.right.lastStart, forKey: "rightTimer")
    userDefaults.setObject(timers.total.lastStart, forKey: "totalTimer")
  }
  
  func reset() {
    // remember the button state
    lastOn = currentOn
    // turn off the buttons
    currentOn = .None
    timers.left.reset()
    timers.right.reset()
    timers.total.reset()
  }
  
}
