//
//  FeedTime.swift
//  breastFeed
//
//  Created by Brown Magic on 9/16/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation
import RealmSwift

// FeedData model
class FeedData: Object {
  dynamic var durationInSeconds:Double = 0
  dynamic var endTime:NSDate = NSDate()
}