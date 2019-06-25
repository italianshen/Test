//
//  Dictionary+Extension.swift
//  Oceans
//
//  Created by admin on 2019/6/5.
//  Copyright © 2019 Phoenixtv. All rights reserved.
//

import Foundation
extension Dictionary {
    func toJsonString(_ prettyPrinted:Bool = false) -> String {
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        
        
        if JSONSerialization.isValidJSONObject(self) {
            
            do{
                let data = try JSONSerialization.data(withJSONObject: self, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }catch {
                
                print("error")
                //Access error here
            }
        }
        return ""
        
    }
}
