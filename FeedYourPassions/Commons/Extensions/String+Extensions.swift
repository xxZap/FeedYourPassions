//
//  String.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 05/06/24.
//

import Foundation

extension String {
    func toMarkdown() -> AttributedString {
        do {
            return try AttributedString(markdown: self)
        } catch {
            return AttributedString(self)
        }
    }
}
