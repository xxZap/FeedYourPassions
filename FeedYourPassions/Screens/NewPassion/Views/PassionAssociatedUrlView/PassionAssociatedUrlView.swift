//
//  PassionAssociatedUrlView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 09/06/24.
//

import Meteor
import SwiftUI

struct PassionAssociatedUrlView: View {

    var associatedURL: String
    var associatedApp: SupportedApplication?
    var supportedApps: [SupportedApplication?]

    var onEditAssociatedURL: (String) -> Void
    var onEditAssociatedApp: (SupportedApplication?) -> Void

    var onAssociatedURLDefinition: () -> Void
    var onAssociatedAppDefinition: () -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            MTextField(
                text: Binding(
                    get: { associatedURL },
                    set: { onEditAssociatedURL($0) }
                ),
                placeholder: "Associated URL",
                title: "Associated URL (optional)",
                isMandatory: false
            ) {
                onAssociatedURLDefinition()
            }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.none)

            MDivider(type: .string("OR"))

            MMenuPicker(
                selectedElement: Binding(
                    get: { associatedApp?.toMenuPickerElement() },
                    set: { onEditAssociatedApp($0?.toSupportedApplication()) }
                ),
                elements: supportedApps.map { $0?.toMenuPickerElement() },
                title: "Associated APP (optional)",
                isMandatory: false
            ) {
                onAssociatedAppDefinition()
            }
        }
    }
}

#if DEBUG
#Preview {
    ScrollView {
        PassionAssociatedUrlView(
            associatedURL: "",
            associatedApp: nil,
            supportedApps: [nil],
            onEditAssociatedURL: { _ in },
            onEditAssociatedApp: { _ in },
            onAssociatedURLDefinition: { },
            onAssociatedAppDefinition: { }
        )
    }
    .background(Color.mBackground)
}
#endif
