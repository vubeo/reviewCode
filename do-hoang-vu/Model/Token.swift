//
//  Token.swift
//  do-hoang-vu
//
//  Created by Đỗ Hoàng Vũ on 7/12/18.
//  Copyright © 2018 Đỗ Hoàng Vũ. All rights reserved.
//

import Foundation
typealias JSON = Dictionary<AnyHashable, Any>

class Token {
    var token : String?
    var code : String?
    
    init?(dict: JSON) {
        guard let token = dict["body"] as? String else {return}
        guard let code = dict["code"] as? String else {return}
        
        self.token = token
        self.code = code
        
    }
}
