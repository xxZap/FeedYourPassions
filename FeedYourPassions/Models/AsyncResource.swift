//
//  AsyncResource.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 23/04/24.
//

import Foundation

enum AsyncResource<T> {
    case loading
    case failure(Error)
    case success(T)

    var successOrNil: T? {
        switch self {
        case .success(let item):
            return item
        default:
            return nil
        }
    }

    func map<R>(mapCompletion: ((T) -> R)) -> AsyncResource<R> {
        switch self {
        case .loading:
            return .loading
        case .failure(let error):
            return .failure(error)
        case .success(let item):
            return .success(mapCompletion(item))
        }
    }
}
