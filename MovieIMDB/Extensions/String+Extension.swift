//
//  String+Extension.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 12/12/23.
//

import Foundation

extension String {
    
    var length: Int {
        return self.count
    }
    
    func maxLength(_ length: Int = 250) -> String {
        var str = self
        let nsString = str as NSString
        if nsString.length >= length {
            str = nsString.substring(with: NSRange( location: 0,
                                                    length: nsString.length > length ? length : nsString.length))
            str += " ..."
        }
        return  str
    }
    
    func showBRData() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "pt-br")
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        
        return "\(day)/\(month)/\(year)"
    }
    
    
    
}
