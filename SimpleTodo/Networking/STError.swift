//
//  STError.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation

// Simple Todo Errors
enum STError: Error, Equatable {
    case invalidURL
    case checkInternetConnection
    case invalidResponse
    case invalidData
    case failedDecoding
    case coreDataError
    case customValue(String)
    
    var value: String {
        switch self {
        case .invalidURL:
            return "This URL Created an invalid request"
        case .checkInternetConnection:
            return "Unable to complete your request, check your internet connection"
        case .invalidResponse:
            return "Invalid response from the server"
        case .invalidData:
            return "The data recieved from the server was invalid"
        case .failedDecoding:
            return "Error while decoding, make sure your data matching response json"
        case .coreDataError:
            return "Error while trying to apply CRUD operation on local database"
        case .customValue(let value):
            return value
        }
    }
}
