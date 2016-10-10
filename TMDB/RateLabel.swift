//
//  RateLabel.swift
//  TMDB
//
//  Created by Георгий Кажуро on 08.09.16.
//  Copyright © 2016 Георгий Кажуро. All rights reserved.
//

import Foundation
import UIKit

class RateLabel: UILabel {
    
    
    enum RateColors: Int {
        case ten = 0x14A840
        case nine = 0x63C933
        case eight = 0xB9DB2A
        case seven = 0xFEBE0B
        case six = 0xFD830A
        case five = 0xDB752D
        case four = 0xD8582D
        case three = 0xDD522D
        case two = 0xEA3A2D
        case one = 0xFA1C1A
    }
    
    func setColor() {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        let rate = Double(self.text!)!
        if 9.0 ... 10.0 ~= rate {
            self.backgroundColor = UIColor(netHex: RateColors.ten.rawValue)
        }
        else if 8.0 ... 9.0 ~= rate {
            self.backgroundColor = UIColor(netHex: RateColors.nine.rawValue)
        }
        else if 7.0 ... 8.0 ~= rate {
            self.backgroundColor = UIColor(netHex: RateColors.eight.rawValue)
        }
        else if 6.0 ... 7.0 ~= rate {
            self.backgroundColor = UIColor(netHex: RateColors.seven.rawValue)
        }
        else if 5.0 ... 6.0 ~= rate {
            self.backgroundColor = UIColor(netHex: RateColors.six.rawValue)
        }
        else if 4.0 ... 5.0 ~= rate {
            self.backgroundColor = UIColor(netHex: RateColors.five.rawValue)
        }
        else if 3.0 ... 4.0 ~= rate {
            self.backgroundColor = UIColor(netHex: RateColors.four.rawValue)
        }
        else if 2.0 ... 3.0 ~= rate {
            self.backgroundColor = UIColor(netHex: RateColors.three.rawValue)
        }
        else if 1.0 ... 2.0 ~= rate {
            self.backgroundColor = UIColor(netHex: RateColors.two.rawValue)
        }
        else if 0.1 ... 1.0 ~= rate {
            self.backgroundColor = UIColor(netHex: RateColors.one.rawValue)
        }
        else if rate == 0.0 {
            self.backgroundColor = UIColor.gray
        }

    }
}
