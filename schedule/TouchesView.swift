//
//  TouchesView.swift
//  schedule
//
//  Created by SuGuocai on 2018/5/23.
//  Copyright © 2018年 魔方. All rights reserved.
//

import Foundation
import UIKit

protocol ToucesViewDelegate {
    func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView?;
}

class TouchesView: UIView {
    var delegate : ToucesViewDelegate!
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return delegate.hitTest(point,with: event)
    }
}
