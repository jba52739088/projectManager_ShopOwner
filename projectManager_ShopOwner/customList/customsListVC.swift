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
    
    var customsList: [eventModel] = []
    var didConfirmList: [Dictionary<String, String>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getWatingMatchMemberRequest { (_customsList) in
            guard let customsList = _customsList else { return }
            self.customsList = customsList
        }
        
    }
    
    @IBAction func switchSegment(_ sender: Any) {
        UIView.performWithoutAnimation {
            self.tableView.reloadData()
        }
        
    }

    @IBAction func clickQRCodeBtn(_ sender: Any) {
        
    }
}

extension customsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.segment.selectedSegmentIndex == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell_1") as! customAddListCell
            
            return cell
        }else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell_2") as! customsListCell
            
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
