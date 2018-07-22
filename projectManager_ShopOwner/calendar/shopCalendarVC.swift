//
//  shopCalendarVC.swift
//  projectManager
//
//  Created by 黃恩祐 on 2018/7/22.
//  Copyright © 2018年 ENYUHUANG. All rights reserved.
//

import UIKit

class shopCalendarVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var calendarVC: calendarVC?
    var matchedMembers: [MatchedMember] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.getMatchedMembers()
        
    }

    func getMatchedMembers() {
        self.matchedMemberRequest { (_members) in
            guard let members = _members else { return }
            self.matchedMembers = members
            self.tableView.reloadData()
        }
    }
}

extension shopCalendarVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchedMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.selectionStyle = .none
        cell.textLabel?.text = self.matchedMembers[indexPath.row].M_NAME
        
        return cell
    }
}
