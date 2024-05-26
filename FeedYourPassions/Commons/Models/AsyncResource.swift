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

    func asyncMap<R>(mapCompletion: ((T) -> R)) -> AsyncResource<R> {
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

extension AsyncResource: Equatable {
    static func == (lhs: AsyncResource<T>, rhs: AsyncResource<T>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case let (.failure(lhsError), .failure(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case let (.success(lhsItem), .success(rhsItem)):
            return lhsItem == rhsItem
        default:
            return false
        }
    }
}

private func ==<L, R>(lhs: L, rhs: R) -> Bool {
    guard
        let equatableLhs = lhs as? any Equatable,
        let equatableRhs = rhs as? any Equatable
    else {
        return false
    }

    return equatableLhs.isEqual(equatableRhs)
}

private extension Equatable {
    func isEqual(_ other: any Equatable) -> Bool {
        guard let other = other as? Self else {
            return other.isExactlyEqual(self)
        }
        return self == other
    }

    private func isExactlyEqual(_ other: any Equatable) -> Bool {
        guard let other = other as? Self else {
            return false
        }
        return self == other
    }
}
