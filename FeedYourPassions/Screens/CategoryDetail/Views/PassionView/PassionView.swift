//
//  PassionView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 27/04/24.
//

import Meteor
import SwiftUI
import Factory
import FirebaseFirestore

struct PassionViewUICalls {
    var onTap: (() -> Void)
    var onLaunchTap: ((URL) -> Void)
    var onAddRecordTap: (() -> Void)
    var onEditColorTap: (() -> Void)
    var onRenameTap: (() -> Void)
    var onEditURLTap: (() -> Void)
    var onDeleteTap: (() -> Void)
}

struct PassionView: View {

    @StateObject var viewModel: PassionViewModel
    let uiCalls: PassionViewUICalls

    var body: some View {
        HStack(spacing: 0) {
            avatarView

            VStack(spacing: 0) {
                HStack(spacing: 8) {
                    VStack(spacing: 4) {
                        latestUpdateLabel
                        title
                    }
                    .padding(.vertical, 8)

                    trailingControls
                }
            }
        }
        .background(Color.mBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
        .shadow(radius: 8)
        .contextMenu(ContextMenu(menuItems: {
            // Launch
            let url = viewModel.associatedURL
            Button {
                if let url { uiCalls.onLaunchTap(url) }
            } label: {
                Label("Launch", systemImage: "arrow.up.forward.app")
            }
            .disabled(url == nil)

            // Add record
            Button {
                uiCalls.onAddRecordTap()
            } label: {
                Label("Add record", systemImage: "plus")
            }

            // Customize color
            Button {
                uiCalls.onEditColorTap()
            } label: {
                Label("Edit Color", systemImage: "drop.halffull")
            }

            // Rename
            Button {
                uiCalls.onRenameTap()
            } label: {
                Label("Rename", systemImage: "character.cursor.ibeam")
            }

            // Edit URL
            Button {
                uiCalls.onEditURLTap()
            } label: {
                if url != nil {
                    Label("Edit URL", systemImage: "link")
                } else {
                    Label("Add URL", systemImage: "link")
                }
            }

            // Delete
            Button(role: .destructive) {
                uiCalls.onDeleteTap()
            } label: {
                Label("Delete passion", systemImage: "xmark.bin")
            }
        }))
    }

    private var avatarView: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(viewModel.color ?? Color.mBackgroundDark)
            .stroke(Color.mBorder, lineWidth: 2)
            .frame(width: 48, height: 64)
            .padding(12)
    }

    private var title: some View {
        Text(viewModel.passion.name)
            .font(.body.weight(.semibold))
            .foregroundStyle(Color.mLightText)
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
    }

    private var latestUpdateLabel: some View {
        HStack(spacing: 6) {
            Text("\(viewModel.passion.recordsCount)")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(Color.mAccent)
                .lineLimit(1)
            Circle()
                .fill(Color.mAccentDark)
                .frame(width: 3, height: 3)
                .clipShape(Capsule())
            Text(viewModel.latestUpdateString)
                .font(.caption2.weight(.medium))
                .foregroundStyle(Color.mAccentDark)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
    }

    private var trailingControls: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
            MIconButton(type: .primaryGhost, size: .small, image: Image(systemName: "plus")) {
                uiCalls.onAddRecordTap()
            }
            .padding(.horizontal, 8)
            if let url = viewModel.associatedURL {
                Spacer(minLength: 0)
                MIconButton(type: .primaryGhost, size: .small, image: Image(systemName: "arrow.up.forward.app")) {
                    uiCalls.onLaunchTap(url)
                }
                .padding(.horizontal, 8)
            }
            Spacer(minLength: 0)
        }
    }
}

#if DEBUG
#Preview {
    let _ = Container.shared.categoryDetailController.register {
        MockedCategoryDetailController(.valid(items: []))
    }
    return VStack {
        Spacer()
        PassionView(
            viewModel: .init(
                passion: .init(
                    name: "Passion",
                    associatedURL: "some",
                    recordsCount: 0,
                    latestUpdate: Timestamp(date: Date()),
                    color: Color.blue.toHex() ?? ""
                )
            ),
            uiCalls: .init(
                onTap: { },
                onLaunchTap: { _ in },
                onAddRecordTap: { },
                onEditColorTap: { },
                onRenameTap: { },
                onEditURLTap: { },
                onDeleteTap: { }
            )
        )
        Spacer()
    }
    .background(Color.mBackground)
}
#endif
