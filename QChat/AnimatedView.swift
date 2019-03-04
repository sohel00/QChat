//
//  AnimatedView.swift
//  QChat
//
//  Created by Sohel Dhengre on 04/03/19.
//  Copyright © 2019 Sohel Dhengre. All rights reserved.
//

import UIKit

class AnimatedView: UIView {

    enum Direction: Int {
        case FromLeft = 0
        case FromRight = 1
    }
    
    @IBInspectable var direction: Int = 0
    @IBInspectable var delay: Double = 0.0
    
    override func layoutSubviews() {
        initAnimation()
        UIView.animate(withDuration: 1, delay: self.delay, options: .curveEaseIn, animations: {
            if let s = self.superview {
                if self.direction == Direction.FromLeft.rawValue {
                    self.center.x += s.bounds.width
                } else {
                    self.center.x -= s.bounds.width
                }
            }
        }, completion: nil)
    }
    
    func initAnimation(){
        
        if let s = self.superview {
            if direction == Direction.FromLeft.rawValue {
                self.center.x -= s.bounds.width
            } else {
                self.center.x += s.bounds.width
            }
        }
    }

}
