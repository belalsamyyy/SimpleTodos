//
//  BaseModel.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation

struct BaseModel<T: Codable>: Codable {
    let data: [T]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        // Try to decode as an array first
        if let array = try? container.decode([T].self) {
            self.data = array
            
        // if fails, try to decode as a single object
        } else if let single = try? container.decode(T.self) {
            self.data = [single]
            
        } else {
            throw DecodingError.typeMismatch([T].self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected single object or array"))
        }
    }
}
