//
//  LastDuration.swift
//  breastFeed
//
//  Created by Brown Magic on 8/16/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation

class LastDuration {
  var durationInterval:NSTimeInterval!
  let timeFormatter = NSDateComponentsFormatter()
  
  init(startDuration interval:Double = 0.0) {
    self.durationInterval = NSTimeInterval(interval)
    
    // just need the minutes back
    self.timeFormatter.unitsStyle = .Abbreviated
  }
  
  var text: String {
    get {
      let string = self.timeFormatter.stringFromTimeInterval(self.durationInterval)
      return string!
    }
  }
  var interval: Double {
    set {
      self.durationInterval = NSTimeInterval(newValue)
    }
    get {
      
      return self.durationInterval!
    }
  }
}
