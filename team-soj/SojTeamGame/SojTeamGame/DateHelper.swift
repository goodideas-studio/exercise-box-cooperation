//
//  DateHelper.swift
//  SojTeamGame
//
//  Created by EthanLin on 2018/5/18.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import Foundation

struct DateHelper {
    static let shared = DateHelper()
    
    func convertDateFormat()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年M月d日 H:m"
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }
}
