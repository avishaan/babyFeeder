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
  var on: Bool!
  
  var date: NSDate {
    get {
      // take the timeElapsed and convert it to a date
      // time needs to be in the past
      return lastStart.dateByAddingTimeInterval(-timeElapsed)
    }
    set {
      //
    }
  }
  
  var secondsElapsed: Double {
    get {
      let difference = NSDate().timeIntervalSinceDate(lastStart)
      return difference
    }
  }
  
  init() {
    timeElapsed = 0
    // assume button is off
    on = false
  }
  
  private func incrementTimer(seconds: Double) {
    timeElapsed = seconds + timeElapsed
  }
  
  func timerAsDate() -> NSDate {
    
    return NSDate()
  }
  
  func start() {
    if !on {
      // keep track of when the timer started
      // add the seconds elapsed to that date (will allow to remember time)
      lastStart = NSDate().dateByAddingTimeInterval(-timeElapsed)
      // remove the seconds elapsed since it's now built into the date
      timeElapsed = 0
      on = true
    }
  }
  
  // see how much time has elapsed so far and save it
  func stop() {
    // only stop if it was just now on
    if on! {
      // see how many seconds have passed from when the timer started and now
      let timeElapsedLastSinceStart = NSDate().timeIntervalSinceDate(lastStart)
      // increment the timer by this amount
      timeElapsed = timeElapsedLastSinceStart + timeElapsed
      on = false
    }
  }
  
  func reset() {
    timeElapsed = 0
    on = false
  }
  
}
