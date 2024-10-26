//
//  URLRequest+Ext.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation

extension URLRequest {
    func logRequest(_ params: Params) {
        #if DEBUG
        print("================== [URLRequest] ==================")
        print("[URLRequest] ===( \(url!.absoluteURL) )===")
        print("[URLRequest] headers =====> \(allHTTPHeaderFields ?? [:])")
        print("[URLRequest] params =====> \(params)")
        print("\n")
        #endif
    }
}


