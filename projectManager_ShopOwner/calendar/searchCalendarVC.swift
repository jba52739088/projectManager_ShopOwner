//
//  searchCalendarVC.swift
//  projectManager_ShopOwner
//
//  Created by 黃恩祐 on 2018/7/8.
//  Copyright © 2018年 ENYUHUANG. All rights reserved.
//

import UIKit

class searchCalendarVC: UIViewController {
    
    @IBOutlet weak var keyWordTextField: UITextField!
    @IBOutlet weak var beginView: UIView!
    @IBOutlet weak var endView: UIView!
    @IBOutlet weak var beginTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var searchCustomView: UIView!
    @IBOutlet weak var searchCustomLabel: UILabel!
    @IBOutlet weak var searchBtn: UIButton!
    
    var calendarVC: calendarVC?
    let timePicker = UIDatePicker()
    var keyword: String?
    var searchBegin: String?
    var searchEnd: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchBtn.layer.borderColor = UIColor.black.cgColor
        self.searchBtn.layer.borderWidth = 1
        self.searchBtn.layer.cornerRadius = 3
        self.searchBtn.layer.masksToBounds = true
        let tapGestureForSearchBegin = UITapGestureRecognizer(target: self, action: #selector(startTimePicker))
        let tapGestureForSearchEnd = UITapGestureRecognizer(target: self, action: #selector(endTimePicker))
        self.beginView.addGestureRecognizer(tapGestureForSearchBegin)
        self.endView.addGestureRecognizer(tapGestureForSearchEnd)
        
        let date = Date()
        let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formatter_2 = DateFormatter()
        formatter_2.dateFormat = "yyyy年MM月dd日"
        searchEnd = formatter.string(from: date)
        endTimeLabel.text = formatter_2.string(from: date)
        searchBegin = formatter.string(from: lastMonth!)
        beginTimeLabel.text = formatter_2.string(from: lastMonth!)
        print("searchBegin: \(searchBegin)\nsearchEnd: \(searchEnd)")
    }

    @IBAction func doSearch(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        self.calendarVC?.calendarRequest(from: searchBegin!, end: searchEnd!) { (_events) in
            guard let events = _events else { return }
            self.calendarVC?.currentEvents = events
            self.calendarVC?.sortEvents()
            self.calendarVC?.isSearch = true
            self.calendarVC?.searchEnd = self.searchEnd!
            self.calendarVC?.searchBegin = self.searchBegin!
            self.calendarVC?.searchKey = ""
        }
    }
    
    @objc func startTimePicker()  {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        timePicker.datePickerMode = UIDatePickerMode.date
        timePicker.frame = CGRect(x: 0, y: 0, width: 250, height: 300)
        timePicker.backgroundColor = UIColor.white
        vc.view.addSubview(timePicker)
        let editRadiusAlert = UIAlertController(title: "選擇日期", message: "", preferredStyle: UIAlertControllerStyle.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "確定", style: .default, handler: { (_) in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.searchBegin = formatter.string(from: self.timePicker.date)
            let formatter_2 = DateFormatter()
            formatter_2.dateFormat = "yyyy年MM月dd日"
            self.beginTimeLabel.text = formatter_2.string(from: self.timePicker.date)
            print("self.searchBegin: \(self.searchBegin!)")
        }))
        editRadiusAlert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(editRadiusAlert, animated: true)
    }
    
    @objc func endTimePicker()  {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        timePicker.datePickerMode = UIDatePickerMode.date
        timePicker.frame = CGRect(x: 0, y: 0, width: 250, height: 300)
        timePicker.backgroundColor = UIColor.white
        vc.view.addSubview(timePicker)
        let editRadiusAlert = UIAlertController(title: "選擇日期", message: "", preferredStyle: UIAlertControllerStyle.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "確定", style: .default, handler: { (_) in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.searchEnd = formatter.string(from: self.timePicker.date)
            let formatter_2 = DateFormatter()
            formatter_2.dateFormat = "yyyy年MM月dd日"
            self.endTimeLabel.text = formatter_2.string(from: self.timePicker.date)
            print("self.searchEnd: \(self.searchEnd!)")
        }))
        editRadiusAlert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(editRadiusAlert, animated: true)
    }
}
