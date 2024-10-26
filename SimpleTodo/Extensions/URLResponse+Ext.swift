//
//  URLResponse+Ext.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation

extension HTTPURLResponse {
    func logResponse(_ data: Data?) {
        #if DEBUG
        print("================== [URLResponse] ==================")
        print("[URLResponse] ===( \(url!.absoluteURL) )===")
        print("[URLResponse] status =====> \(statusCode)")
        print("[URLResponse] headers =====> \(allHeaderFields)\n")
        print("[URLResponse] result ======> \(dataJson(data))")
        print("\n")
        #endif
    }
     
    private func dataJson(_ data: Data?) -> String {
        do {
            if let data {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let prettyPrintedData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8)
                return prettyPrintedString ?? "Error"
            }
        } catch {
            print("Error parsing JSON: \(error)")
        }
        
        return "error: something went wrong"
    }
}

