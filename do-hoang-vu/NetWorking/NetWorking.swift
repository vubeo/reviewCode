
//  NetWorking.swift
//  do-hoang-vu
//
//  Created by Đỗ Hoàng Vũ on 7/13/18.
//  Copyright © 2018 Đỗ Hoàng Vũ. All rights reserved.
//

//import Foundation
//typealias temJSON = [String : Any]
//
//class APICLient {
//   
//    static func getItemNameAPI(completion : @escaping (temJSON?)-> Void) {
//        let baseUrl = "http://192.168.10.30/MappingLocate/api/getAllCate?token="
//        let token = UserDefaults.standard.string(forKey: "token")
//        let urlOfficial = baseUrl + token!
//        let urls = URL(string: urlOfficial)
//        print(urlOfficial)
//        let session = URLSession.shared
//        guard let unweappedURl = urls else {
//            print("Error unwrapping url")
//            return
//        }
//        let dataTask = session.dataTask(with: unweappedURl) { (data, response, error) in
//            guard let data = data  else {return}
//            
//            do{
//                let responseJson = try JSONSerialization.jsonObject(with: data, options: []) as? temJSON
//                completion(responseJson)
//            }
//            catch {
//                print(error.localizedDescription)
//            }
//        }
//   
//        dataTask.resume()
//        
//    }
//}

