//
//  DoubleExtension.swift
//  TMDB
//
//  Created by Георгий Кажуро on 08.09.16.
//  Copyright © 2016 Георгий Кажуро. All rights reserved.
//

import Foundation

extension Double {
    func format(_ f: Int) -> String {
        let formatStr = ".\(f)"
        return String(format: "%\(formatStr)f", self)
    }
}
