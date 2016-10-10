//
//  StringExtension.swift
//  TMDB
//
//  Created by Георгий Кажуро on 07.09.16.
//  Copyright © 2016 Георгий Кажуро. All rights reserved.
//

import Foundation

extension String
{
    func replace(_ target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func toDate() -> Date! {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
