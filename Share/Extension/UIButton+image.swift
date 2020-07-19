//
//  UIButton+image.swift
//  LonelyPlanet
//
//  Created by sugc on 2018/11/25.
//  Copyright © 2018 sugc. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func setStatuesImage(normalImage:String!, hilightImage:String!) {
        self.setImage(UIImage.init(named: normalImage), for: UIControl.State.normal)
        self.setImage(UIImage.init(named: hilightImage), for: UIControl.State.highlighted)
    }
    
}
