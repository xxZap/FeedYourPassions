//
//  PassionViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 27/04/24.
//

import SwiftUI
import Combine
import Factory

private var relativeDateFormatter: RelativeDateTimeFormatter = {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    return formatter
}()

class PassionViewModel: ObservableObject {

    var passion: Passion
    var latestUpdateString: String
    var color: Color? { Color(hex: passion.color) }
    var associatedURL: URL? { if let string = passion.associatedURL { URL(string: string) } else { nil } }

    @Injected(\.categoryDetailController) private var categoryDetailController

    init(passion: Passion) {
        self.passion = passion
        self.latestUpdateString = relativeDateFormatter.localizedString(
            for: passion.latestUpdate.dateValue(),
            relativeTo: Date.now
        )
    }
}
