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
  
  enum State {
    case Active
    case LastOn
    case None
  }
  
  enum Side {
    case Left
    case Right
    case None
  }
  
  init() {
    // initialize the two timers
    timers.left = Timer()
    timers.right = Timer()
    
    // TODO: restore state from previous state
  }
  
  func trigger(side:Side) {
    // store the currentOn as the one that was last on
    lastOn = currentOn
    // if the triggered side is the same as the currentOn side, then just pause the timers
    if side == currentOn {
      timers.left.stop()
      timers.right.stop()
      // set nothing as currentlyOn
      currentOn = .None
    } else {
      // set this side as current on
      currentOn = side
      // turn off all timers
      timers.left.stop()
      timers.right.stop()
      // start the timer for this side
      switch side {
      case .Left:
        timers.left.start()
      case .Right:
        timers.right.start()
      default:
        println("This is an error")
      }
      
    }
    // save the start time into the persistance
    
  }
  
  func restoreState() {
    println("Restore State")
    
  }
  
  func reset() {
    // remember the button state
    lastOn = currentOn
    // turn off the buttons
    currentOn = .None
    timers.left = Timer()
    timers.right = Timer()
  }
  
}
