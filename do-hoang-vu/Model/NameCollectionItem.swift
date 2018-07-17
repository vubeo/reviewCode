//
//  ConlectionText.swift
//  do-hoang-vu
//
//  Created by Đỗ Hoàng Vũ on 7/12/18.
//  Copyright © 2018 Đỗ Hoàng Vũ. All rights reserved.
//

import Foundation

typealias ItemJSON = [String: Any]

class NameCollectionItem {
    var id         : Int
    var slug       : String
    var name       : String
    var name_vi    : String
    var name_en    : String
    var name_cn    : String
    var name_es    : String
    var name_fr    : String
    var type       : String
    init?(dict : JSON) {
        guard let id            = dict["id"]            as? Int    else {return nil}
        guard let slug          = dict["slug"]         as? String else {return nil}
        guard let name          = dict["name"]          as? String else {return nil}
        guard let name_vi       = dict["name_vi"]       as? String else {return nil}
        guard let name_en       = dict["name_en"]       as? String else {return nil}
        guard let name_cn       = dict["name_cn"]       as? String else {return nil}
        guard let name_es       = dict["name_es"]       as? String else {return nil}
        guard let name_fr       = dict["name_fr"]       as? String else {return nil}
        guard let type          = dict["type"]          as? String else {return nil}
        
        self.id         = id
        self.slug       = slug
        self.name       = name
        self.name_vi    = name_vi
        self.name_en    = name_en
        self.name_cn    = name_cn
        self.name_es    = name_es
        self.name_fr    = name_fr
        self.type       = type
    }
}





