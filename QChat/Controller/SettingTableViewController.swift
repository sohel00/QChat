//
//  SettingTableViewController.swift
//  QChat
//
//  Created by Sohel Dhengre on 14/03/19.
//  Copyright © 2019 Sohel Dhengre. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    
    @IBAction func logoutPressed(_ sender: Any) {
        FUser.logOutCurrentUser { (success) in
            if success {
                self.showloginView()
            }
        }
    }
    
    func showloginView() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "welcome")
        self.present(vc, animated: true, completion: nil)
    }
    
}
