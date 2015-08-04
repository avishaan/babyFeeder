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
  
  @IBOutlet weak var leftTimer: WKInterfaceTimer!
  @IBOutlet weak var rightTimer: WKInterfaceTimer!
  @IBOutlet weak var totalTimer: WKInterfaceTimer!
  @IBOutlet weak var leftButton: WKInterfaceButton!
  @IBOutlet weak var rightButton: WKInterfaceButton!
  
  var buttonState = (left: false, right: false)
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  @IBAction func onRightButtonTap() {
    // is the left button on
    if buttonState.left {
      // no matter what, disable the left button if it is enabled
      buttonState.left = false
      leftButton.setBackgroundColor(UIColor.clearColor())
    }
    
    // is this, the right button, on?
    if buttonState.right {
      // if right button is enabled, disable
      buttonState.right = false
      rightButton.setBackgroundColor(UIColor.blackColor())
    } else {
      // if right button is disabled, enable
      buttonState.right = true
      rightButton.setBackgroundColor(UIColor.greenColor())
      
    }
  }
  
  @IBAction func onLeftButtonTap() {
    
    
  }
}
