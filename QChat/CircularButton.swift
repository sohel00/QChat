//
//  CircularButton.swift
//  QChat
//
//  Created by Sohel Dhengre on 04/03/19.
//  Copyright © 2019 Sohel Dhengre. All rights reserved.
//

import UIKit

class CircularButton: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/2
    }

}
