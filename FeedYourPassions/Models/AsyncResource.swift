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
}
