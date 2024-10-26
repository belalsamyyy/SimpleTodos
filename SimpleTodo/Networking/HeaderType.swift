//
//  HeaderType.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation

enum HeaderType {
   case json
   case urlencoded
    
   var contentType: String {
       switch self {
       case .json:
           return "application/json"
       case .urlencoded:
           return "application/x-www-form-urlencoded"
       }
    }
}
