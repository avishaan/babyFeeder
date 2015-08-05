//
//  Timer.swift
//  breastFeed
//
//  Created by Brown Magic on 8/4/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation

class Timer {
  var timeElapsed: Double!
  var lastStart: NSDate!
  
  var date: NSDate {
    get {
      // take the timeElapsed and convert it to a date
      // time needs to be in the past
      return NSDate().dateByAddingTimeInterval(-timeElapsed)
    }
  }
  
  init() {
    timeElapsed = 0
  }
  
  private func incrementTimer(seconds: Double) {
    timeElapsed = seconds + timeElapsed
  }
  
  func timerAsDate() -> NSDate {
    
    return NSDate()
  }
  
  func start() {
    // keep track of when the timer started
    lastStart = NSDate()
  }
  
  // see how much time has elapsed so far and save it
  func stop() {
    // see how many seconds have passed from when the timer started and now
    let timeElapsedLastSinceStart = NSDate().timeIntervalSinceDate(lastStart)
    // increment the timer by this amount
    incrementTimer(timeElapsedLastSinceStart)
    
  }
  
}
