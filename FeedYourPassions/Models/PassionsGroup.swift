//
//  PassionsGroup.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation

struct PassionsGroup: Equatable {
    var name: String
    var passions: [Passion]

    var currentValue: Int {
        passions.isEmpty ? 0 : passions.map { $0.records.count }.reduce(0, +)
    }
}

let mockedGroups: [PassionsGroup] = [
    PassionsGroup(
        name: "Max",
        passions: [
            Passion(
                name: "max",
                associatedURL: nil,
                records: (0..<100).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionsGroup(
        name: "Music",
        passions: [
            Passion(
                name: "Spotify",
                associatedURL: "https://open.spotify.com",
                records: (0..<7).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Concerts",
                associatedURL: nil,
                records: (0..<1).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionsGroup(
        name: "Restaurants",
        passions: [
            Passion(
                name: "Sushi",
                associatedURL: nil,
                records: (0..<4).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Pizza",
                associatedURL: nil,
                records: (0..<1).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionsGroup(
        name: "Sport",
        passions: [
            Passion(
                name: "Gym",
                associatedURL: nil,
                records: (0..<5).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Run",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Trekking 0~500m",
                associatedURL: nil,
                records: (0..<4).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Trekking 501~1000m",
                associatedURL: nil,
                records: (0..<1).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionsGroup(
        name: "Reading",
        passions: [
            Passion(
                name: "Manga",
                associatedURL: nil,
                records: (0..<3).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Books",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionsGroup(
        name: "TV",
        passions: [
            Passion(
                name: "Anime",
                associatedURL: nil,
                records: (0..<2).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "TV Series",
                associatedURL: nil,
                records: (0..<5).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Movies",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionsGroup(
        name: "Teather",
        passions: [
            Passion(
                name: "Opera",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Commedia",
                associatedURL: nil,
                records: (0..<1).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionsGroup(
        name: "Friends",
        passions: [
            Passion(
                name: "Events",
                associatedURL: nil,
                records: (0..<2).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionsGroup(
        name: "Family",
        passions: [
            Passion(
                name: "Family events",
                associatedURL: nil,
                records: (0..<2).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionsGroup(
        name: "Videogames",
        passions: [
            Passion(
                name: "League of Legends",
                associatedURL: nil,
                records: (0..<100).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Dragon's Dogma 2",
                associatedURL: nil,
                records: (0..<100).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "E-Football",
                associatedURL: nil,
                records: (0..<100).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionsGroup(
        name: "Min",
        passions: [
            Passion(
                name: "Minimum",
                associatedURL: nil,
                records: (0..<100).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
]
