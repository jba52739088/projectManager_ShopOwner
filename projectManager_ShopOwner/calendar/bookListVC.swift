//
//  bookListVC.swift
//  projectManager_ShopOwner
//
//  Created by 黃恩祐 on 2018/8/3.
//  Copyright © 2018年 ENYUHUANG. All rights reserved.
//

import UIKit

class bookListVC: UIViewController {

    @IBOutlet weak var displayView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dismissBtn: UIButton!
    
    var scheduleAddVC: scheduleAddVC?
    var bookingList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = UIColor.x
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
        self.view.removeFromSuperview()
        self.navigationController?.pushViewController(self.scheduleAddVC!, animated: true)
        
    }
}

extension bookListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aTime = self.bookingList[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = aTime
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.minimumScaleFactor = 0.2
        cell.selectionStyle = .none
//        cell.sepa
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
}

