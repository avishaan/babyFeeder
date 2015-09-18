//
//  GlanceController.swift
//  breastFeed WatchKit Extension
//
//  Created by Brown Magic on 8/4/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {
  
  var userDefaults = NSUserDefaults.standardUserDefaults()
  
  @IBOutlet weak var lastFeedLabel: WKInterfaceLabel!
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
    var lastFeedDate = restoreLastFeedDate()
    var lastFeedDuration = restoreLastFeedDuration()
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    let lastFeedDateString = dateFormatter.stringFromDate(lastFeedDate)
    
    // combine the last feed date with the last feed duration
    lastFeedLabel.setText(lastFeedDateString + " for " + lastFeedDuration.text)

    
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
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
 
}
