//
//  OPassionsGroup.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation
import FirebaseFirestoreSwift

let mockedCategories: [PassionCategory] = PassionCategoryType.allCases.map { PassionCategory(type: $0) }
enum PassionCategoryType: String, Codable, CaseIterable {
    case music
    case food
    case sport
    case health
    case reading
    case tv
    case theater
    case friends
    case family
    case personal
    case games
    case travel
}

class PassionCategory: Equatable, Hashable, Codable {
    @DocumentID var id: String?
    let type: PassionCategoryType

    var currentValue: Int {
        0// passions.isEmpty ? 0 : passions.map { $0.records.count }.reduce(0, +)
    }

    var maxValue: Int {
        0//passions.map { $0.records.count }.max() ?? 0
    }

    var extendedName: String {
        "\(emoji) \(name)"
    }

    var emoji: String {
        switch type {
        case .music:
            "🎵"
        case .food:
            "🍴"
        case .sport:
            "🏅"
        case .health:
            "❤️"
        case .reading:
            "📖"
        case .tv:
            "📺"
        case .theater:
            "🎭"
        case .friends:
            "😆"
        case .family:
            "🏡"
        case .personal:
            "🌱"
        case .games:
            "🎮"
        case .travel:
            "✈️"
        }
    }

    var name: String {
        switch type {
        case .music:
            "Music"
        case .food:
            "Food"
        case .sport:
            "Sport"
        case .health:
            "Health"
        case .reading:
            "Reading"
        case .tv:
            "TV"
        case .theater:
            "Theater"
        case .friends:
            "Friends"
        case .family:
            "Family"
        case .personal:
            "Personal"
        case .games:
            "Games"
        case .travel:
            "Travel"
        }
    }

    init(type: PassionCategoryType) {
        self.type = type
    }

    static func == (lhs: PassionCategory, rhs: PassionCategory) -> Bool {
        lhs.id == rhs.id
        && lhs.type == rhs.type
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(type)
    }
}
