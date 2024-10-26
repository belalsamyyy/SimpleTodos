//
//  TodoListItemModel.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation

struct TodoListItemModel: Codable {
    var userId: Int?
    var id: Int?
    var title: String
    var completed: Bool
     
    // generate ID for Core Data entity
    var coreDataID: UUID?

    enum CodingKeys: String, CodingKey {
        case userId, id, title, completed
    }
    
    init(userId: Int? = nil, id: Int? = nil, title: String, completed: Bool, coreDataID: UUID = UUID()) {
        self.userId = userId
        self.id = id
        self.title = title
        self.completed = completed
        self.coreDataID = coreDataID
    }
}

