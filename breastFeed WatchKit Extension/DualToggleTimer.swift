//
//  DualToggleTimer.swift
//  breastFeed
//
//  Created by Brown Magic on 8/23/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation

class DualToggleTimer {
  var timers:(left:Timer, right:Timer)!
  enum Side {
    case Left
    case Right
    case Both
  }
  
  init() {
    // initialize the two timers
    timers.left = Timer()
    timers.right = Timer()
    
    // TODO: restore state from previous state
  }
  
  func start(side:Side) {
    if (side == Side.Left) {
      println("left on")
    }
  }
  
  func stop(side:Side) {
    
  }
  
}
