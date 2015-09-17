//
//  ViewController.swift
//  breastFeed
//
//  Created by Brown Magic on 8/4/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class ViewController: UIViewController {

  @IBOutlet weak var barChartView: BarChartView!
  
  let realm = Realm()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    // get data from db
    let feedData = realm.objects(FeedData)
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
    // add bar chart data
    setChart(months, values: unitsSold, feedData: feedData)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  func setChart(dataPoints: [String], values: [Double], feedData:Results<FeedData>) {
    barChartView.noDataText = "You need to provide data for the chart."
    
    var dataEntries:[BarChartDataEntry] = []
    for i in 0..<feedData.count {
      let dataEntry = BarChartDataEntry(value: feedData[i].durationInSeconds, xIndex: i)
      dataEntries.append(dataEntry)
    }
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
    dateFormatter.timeStyle = .ShortStyle
    
    var dataX:[String] = []
    for i in 0..<feedData.count {
      let dataEntry = dateFormatter.stringFromDate(feedData[i].endTime)
      dataX.append(dataEntry)
    }
    
    let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Time Fed")
    let chartData = BarChartData(xVals: dataX, dataSet: chartDataSet)
    barChartView.data = chartData
    
  }
}

