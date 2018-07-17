//
//  LocationRdiusOneKm.swift
//  do-hoang-vu
//
//  Created by Đỗ Hoàng Vũ on 7/17/18.
//  Copyright © 2018 Đỗ Hoàng Vũ. All rights reserved.
//

import Foundation
class LocationRdiusOneKm {
    var address_en : String
    var id : Int
    var lat : String
    var long : String
    var name_en : String
    var category_id : Int
    init?(dict : JSON) {
        guard let address_en = dict["address_en"] as? String else {return nil}
        guard let id = dict["id"] as? Int else { return nil }
        guard let lat = dict["lat"] as? String else {return nil}
        guard let long = dict["long"] as? String else {return nil}
        guard let name_en = dict["name_en"] as? String else {return nil}
        guard let category_id = dict["category_id"] as? Int else {return nil}
        self.address_en = address_en
        self.id = id
        self.lat = lat
        self.long = long
        self.name_en = name_en
        self.category_id = category_id
    }
}
