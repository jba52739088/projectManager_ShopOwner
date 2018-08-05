//
//  scheduleConflictVC.swift
//  projectManager_ShopOwner
//
//  Created by 黃恩祐 on 2018/7/16.
//  Copyright © 2018年 ENYUHUANG. All rights reserved.
//

import UIKit

class scheduleConflictVC: UIViewController {

    @IBOutlet weak var displayView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dismissBtn: UIButton!
    
    var scheduleAddVC: scheduleAddVC?
    var conflictArray: [Dictionary<String,String>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
        self.displayView.layer.borderColor = UIColor.black.cgColor
        self.displayView.layer.borderWidth = 1
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.minimumScaleFactor = 0.2
        self.dismissBtn.layer.borderColor = UIColor.black.cgColor
        self.dismissBtn.layer.borderWidth = 1
        self.dismissBtn.layer.cornerRadius = 3
        self.dismissBtn.layer.masksToBounds = true
        
        
        self.tableView.tableFooterView = UIView()
    }
    
    @IBAction func doDismiss(_ sender: Any) {
        self.scheduleAddVC?.popWindowsDidRemove()
    }
}

extension scheduleConflictVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conflictArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aConflict = self.conflictArray[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 4
//        cell.textLabel?.text = aConflict["GUEST"]! + " " + aConflict["C_DATE_START"]! + " " + aConflict["MEETING_TITLE"]!
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        cell.textLabel?.text = aConflict["C_DATE_START"]! + " - " + aConflict["C_DATE_END"]! + "\n" + aConflict["GUEST"]! + " - " + aConflict["MEETING_TITLE"]!
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.minimumScaleFactor = 0.1
        cell.selectionStyle = .none
        return cell
    }
    

    
}
