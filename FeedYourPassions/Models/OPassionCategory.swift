//
//  OPassionsGroup.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation

struct OPassionCategory: Equatable {
    var name: String
    var passions: [OPassion]

    var currentValue: Int {
        passions.isEmpty ? 0 : passions.map { $0.records.count }.reduce(0, +)
    }
}

let mockedCategories: [OPassionCategory] = [
    OPassionCategory(
        name: "Music",
        passions: [
            OPassion(
                id: UUID(),
                name: "Spotify",
                associatedURL: "https://open.spotify.com",
                records: (0..<7).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                id: UUID(),
                name: "Concerts",
                associatedURL: nil,
                records: (0..<1).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "Food",
        passions: [
            OPassion(
                id: UUID(),
                name: "Sushi",
                associatedURL: nil,
                records: (0..<4).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                id: UUID(),
                name: "Pizza",
                associatedURL: nil,
                records: (0..<1).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "Sport",
        passions: [
            OPassion(
                id: UUID(),
                name: "Gym",
                associatedURL: nil,
                records: (0..<5).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                id: UUID(),
                name: "Run",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                id: UUID(),
                name: "Trekking 0~500m",
                associatedURL: nil,
                records: (0..<4).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                id: UUID(),
                name: "Trekking 501~1000m",
                associatedURL: nil,
                records: (0..<1).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "Health",
        passions: [
            OPassion(
                id: UUID(),
                name: "Dentist",
                associatedURL: nil,
                records: (0..<100).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                id: UUID(),
                name: "Medical Examinations",
                associatedURL: nil,
                records: (0..<100).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                id: UUID(),
                name: "Spa",
                associatedURL: nil,
                records: (0..<100).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "Reading",
        passions: [
            OPassion(
                id: UUID(),
                name: "Manga",
                associatedURL: nil,
                records: (0..<3).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                id: UUID(),
                name: "Books",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "TV",
        passions: [
            OPassion(
                id: UUID(),
                name: "Anime",
                associatedURL: nil,
                records: (0..<2).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                id: UUID(),
                name: "TV Series",
                associatedURL: nil,
                records: (0..<5).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                id: UUID(),
                name: "Movies",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                id: UUID(),
                name: "Cinema",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                id: UUID(),
                name: "Netflix",
                associatedURL: "nflx://www.netflix.com",
                records: (0..<2).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "Theater",
        passions: [
            OPassion(
                id: UUID(),
                name: "Opera",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                id: UUID(),
                name: "Commedia",
                associatedURL: nil,
                records: (0..<1).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "Friends",
        passions: [
            OPassion(
                id: UUID(),
                name: "Friends events",
                associatedURL: nil,
                records: (0..<2).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "Family",
        passions: [
            OPassion(
                id: UUID(),
                name: "Family events",
                associatedURL: nil,
                records: (0..<2).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "Videogames",
        passions: [
            OPassion(
                id: UUID(),
                name: "League of Legends",
                associatedURL: nil,
                records: (0..<100).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                id: UUID(),
                name: "Dragon's Dogma 2",
                associatedURL: nil,
                records: (0..<100).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                id: UUID(),
                name: "E-Football",
                associatedURL: nil,
                records: (0..<100).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    )
]
