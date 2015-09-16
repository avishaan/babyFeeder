//
//  FeedTime.swift
//  breastFeed
//
//  Created by Brown Magic on 9/16/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation
import RealmSwift

// Dog model
class FeedTime: Object {
  dynamic var side = ""
  dynamic var birthdate = NSDate(timeIntervalSince1970: 1)
}