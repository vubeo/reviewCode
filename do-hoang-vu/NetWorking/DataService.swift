//
//  DataService.swift
//  do-hoang-vu
//
//  Created by Anh Hao on 7/10/18.
//  Copyright © 2018 Đỗ Hoàng Vũ. All rights reserved.
//

import Foundation
class DataService {
    static let shared: DataService = DataService()
    var result = [String]()
//     func locateWithLongitude(_ lon:Double, andLatitude lat:Double, andTitle title: String)
    var lon: Double = 0.0
    var lat: Double = 0.0
    var title: String = ""
    
}
