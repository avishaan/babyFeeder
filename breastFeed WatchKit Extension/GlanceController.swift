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
  
  @IBOutlet weak var lastFeedLabel: WKInterfaceLabel!
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
    var lastFeed = restoreLastFeedDate()
    
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
    var userDefaults = NSUserDefaults.standardUserDefaults()
    let lastFeed = userDefaults.objectForKey("lastFeedDate") as? NSDate
    if lastFeed == nil {
      // if last feed is nil, it's our first time accessing it and set it to now
      return NSDate()
    } else {
      // return the retreived value
      return lastFeed!
    }
  }
  
}
