//
//  SettingViewController.swift
//  schedule
//
//  Created by sugc on 2019/1/25.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation

class DetailFunctionViewController : UIViewController {
    
    private var tableView : UITableView!
    private var tableViewManager : DetailFunctionManager = DetailFunctionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func layout() {
        self.view.backgroundColor = UIColor.white
        let tableViewFrame = CGRect(x: CGFloat(0),
                                    y: iPhoneXSafeDistanceTop,
                                    width: ScreenWidth,
                                    height: ScreenHeight - iPhoneXSafeDistanceTop -
                                        self.tabBarController!.tabBar.height)
        tableView = UITableView.init(frame: tableViewFrame, style: UITableView.Style.grouped)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.register(DetailFuncTableViewCell.classForCoder(), forCellReuseIdentifier: "deatilFuncCell")
        tableView.delegate = tableViewManager
        tableView.dataSource = tableViewManager
        self.view.addSubview(tableView)
        //
        
    }
    

}
