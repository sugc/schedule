//
//  ATestHandler.swift
//  schedule
//
//  Created by sugc on 2019/6/29.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation

class ATestHandler : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "lkjhgf")
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = UIColor.red
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }

    

}

