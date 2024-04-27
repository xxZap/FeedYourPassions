//
//  PassionView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 27/04/24.
//

import SwiftUI
import Meteor

struct PassionView: View {

    @Environment(\.alerterKey) var alerter

    @ObservedObject var viewModel: PassionViewModel
    let barColor: Color

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                Text(viewModel.passion.name)
                    .font(.body)
                    .foregroundStyle(Color.mLightText)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("\(viewModel.passion.records.count)")
                    .font(.body.weight(.bold))
                    .foregroundStyle(Color.mLightText)
                    .multilineTextAlignment(.trailing)
                    .frame(alignment: .trailing)
            }

            HStack(alignment: .bottom, spacing: 8) {
                MProgressView(
                    value: viewModel.passion.records.count,
                    total: viewModel.maxValue,
                    color: barColor
                )

                MIconButton(type: .secondary, size: .small, image: Image(systemName: "plus")) {
                    viewModel.addRecord()
                }
            }
        }
        .onChange(of: viewModel.alertContainer) { old, new in
            alerter.alert = new?.alert
        }
    }
}
