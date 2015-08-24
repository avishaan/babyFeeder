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
  var lastOn:Side!
  var currentOn:Side!
  enum Side {
    case Left
    case Right
    case Both
  }
  
  init() {
    // initialize the two timers
    timers.left = Timer()
    timers.right = Timer()
    lastOn = .Both
    
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
