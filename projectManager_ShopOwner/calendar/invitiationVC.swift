//
//  invitiationVC.swift
//  projectManager
//
//  Created by 黃恩祐 on 2018/7/25.
//  Copyright © 2018年 ENYUHUANG. All rights reserved.
//

import UIKit

class invitiationVC: UIViewController {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var DoneBtn: UIBarButtonItem!
    
    var customsList: [[String: String]] = []
    var didConfirmList: [[String: String]] = []
    var calendarVC: calendarVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.requestCustomsList()
        self.requestDidConfirmList()
    }
    
    @IBAction func switchSegment(_ sender: Any) {
        if self.segment.selectedSegmentIndex == 0 {
            requestCustomsList()
        }else {
            requestDidConfirmList()
        }
    }
    
    @IBAction func clickDoneBtn(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func requestCustomsList() {
        self.getInboxNewRequest { (_list) in
            guard let list = _list else { return }
            self.customsList = list
            UIView.performWithoutAnimation {
                self.tableView.reloadData()
            }
        }
    }
    
    func requestDidConfirmList() {
        self.getInboxDoneRequest { (_customsList) in
            guard let customsList = _customsList else { return }
            self.didConfirmList = customsList
            UIView.performWithoutAnimation {
                self.tableView.reloadData()
            }
        }
    }
}

extension invitiationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.segment.selectedSegmentIndex == 0 {
            return customsList.count
        }else {
            return didConfirmList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! invitiationCell
        cell.invitiationVC = self
        if self.segment.selectedSegmentIndex == 0 {
            cell.title.text = self.customsList[indexPath.row]["P_CLASS"]
            cell.secondTitle.text = self.customsList[indexPath.row]["MEETING_TITLE"]
            cell.name.text = self.customsList[indexPath.row]["GUEST"]
            cell.time.text = self.customsList[indexPath.row]["C_DATE_END"]
            cell.ce_id = self.customsList[indexPath.row]["CE_ID"]!
            cell.acceptBtn.isUserInteractionEnabled = true
            cell.rejectBtn.isUserInteractionEnabled = true
            cell.acceptBtn.isSelected = false
            cell.rejectBtn.isSelected = false
        }else {
            cell.title.text = self.didConfirmList[indexPath.row]["P_CLASS"]
            cell.secondTitle.text = self.didConfirmList[indexPath.row]["MEETING_TITLE"]
            cell.name.text = self.didConfirmList[indexPath.row]["GUEST"]
            cell.time.text = self.didConfirmList[indexPath.row]["C_DATE_END"]
            cell.acceptBtn.isUserInteractionEnabled = false
            cell.rejectBtn.isUserInteractionEnabled = false
            if (self.didConfirmList[indexPath.row]["STATUS"]!) == "1" {
                cell.acceptBtn.isSelected = true
                cell.rejectBtn.isSelected = false
            }else {
                cell.acceptBtn.isSelected = false
                cell.rejectBtn.isSelected = true
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

