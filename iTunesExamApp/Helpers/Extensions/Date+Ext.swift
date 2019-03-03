//
//  Date+Ext.swift
//  iTunesExamApp
//
//  Created by Aicha on 03/03/2019.
//  Copyright © 2019 Aiza Simbra. All rights reserved.
//

import Foundation

extension Date{
    
    //MARK: convert Date to String in format yyyy-mm-dd hh:mm:ss
    func dateTo_YYYYMMDD_HHMMSS_format() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: self)
    }
    
    //MARK: convert Date to String in format e.g. Sunday, 1 January 1991 hh:mm
    func dateTo_DDMMMMYYYY_format() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, dd MMMM yyyy HH:mm"
        
        return dateFormatter.string(from: self)
    }
}
