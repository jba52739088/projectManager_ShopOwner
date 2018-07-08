//
//  customsListVC.swift
//  projectManager_ShopOwner
//
//  Created by 黃恩祐 on 2018/7/8.
//  Copyright © 2018年 ENYUHUANG. All rights reserved.
//

import UIKit

class customsListVC: UIViewController {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var QRcodeBtn: UIBarButtonItem!
    
    var customsList: [MatchedMember] = []
    var didConfirmList: [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    @IBAction func clickQRCodeBtn(_ sender: Any) {
        self.getIDbyTokenRequest { (_QRCode_String) in
        guard let QRCode_String = _QRCode_String else { return }
            print("QRCode_String: \(QRCode_String)")
            if let QRCodeVC = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeVC") as? QRCodeVC {
                QRCodeVC.QRcode = QRCode_String
                self.navigationController?.pushViewController(QRCodeVC, animated: true)
            }
        }
        
    }
    
    func requestCustomsList() {
        self.getWatingMatchMemberRequest { (_customsList) in
            guard let customsList = _customsList else { return }
            self.customsList = customsList
            UIView.performWithoutAnimation {
                self.tableView.reloadData()
            }
        }
    }
    
    func requestDidConfirmList() {
        self.getAuditedMatchMemberRequest { (_customsList) in
            guard let customsList = _customsList else { return }
            self.didConfirmList = customsList
            UIView.performWithoutAnimation {
                self.tableView.reloadData()
            }
        }
    }
}

extension customsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.segment.selectedSegmentIndex == 0 {
            return customsList.count
        }else {
            return didConfirmList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.segment.selectedSegmentIndex == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell_1") as! customAddListCell
            cell.nameLabel.text = "客戶姓名： " + self.customsList[indexPath.row].M_NAME
            cell.mailLabel.text = "E-mail： " + self.customsList[indexPath.row].M_MAIL
            cell.phoneLabel.text = "電話： " + self.customsList[indexPath.row].M_TEL_D
            return cell
        }else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell_2") as! customsListCell
            cell.nameLabel.text = self.didConfirmList[indexPath.row].keys.first
            cell.timeLabel.text = "最後登入時間： " + self.didConfirmList[indexPath.row].values.first!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.segment.selectedSegmentIndex == 0 {
            return 120
        }else{
            return 60
        }
    }
    
}
