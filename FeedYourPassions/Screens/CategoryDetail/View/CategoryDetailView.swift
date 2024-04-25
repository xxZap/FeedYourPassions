//
//  CategoryDetailView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 23/04/24.
//

import SwiftUI
import Combine
import Meteor

class CategoryDetailViewModel: ObservableObject {
    @Published var category: OPassionCategory

    init(category: OPassionCategory) {
        self.category = category
    }
}

struct CategoryDetailView: View {

    @ObservedObject var viewModel: CategoryDetailViewModel

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List(viewModel.category.passions.indices, id: \.self) { index in
                let passion = viewModel.category.passions[index]
                PassionView(
                    viewModel: .init(passion: passion),
                    maxValue: viewModel.category.maxValue,
                    barColor: Color.mGetColor(forListIndex: index)
                )
                .listRowBackground(Color.clear)

                if index == viewModel.category.passions.count - 1 {
                    Rectangle()
                        .fill(.clear)
                        .listRowBackground(Color.clear)
                        .frame(height: 100)
                }
            }
            .listStyle(.plain)

            MSideButton(
                onTap: createNewPassion,
                image: Image(systemName: "plus"),
                side: .attachedToTheRight
            )
            .padding(.bottom, 32)
        }
        .background(Color.mBackground)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(viewModel.category.name)
    }

    private func createNewPassion() {
        // ZAPTODO: missing implementation
    }
}

#if DEBUG
#Preview {
    CategoryDetailView(
        viewModel: .init(
            category: .init(
                name: "Category name",
                passions: [
                    .init(name: "Passion1", associatedURL: nil, records: [
                        .init(date: Date())
                    ]),
                    .init(name: "Passion2", associatedURL: nil, records: [
                        .init(date: Date()),
                        .init(date: Date())
                    ])
                ]
            )
        )
    )
}
#endif

class PassionViewModel: ObservableObject {

    struct AlertContainer: Equatable {
        static func == (lhs: PassionViewModel.AlertContainer, rhs: PassionViewModel.AlertContainer) -> Bool {
            lhs.id == rhs.id
        }
        
        let id = UUID()
        let alert: Alert
    }

    @Published var passion: OPassion
    @Published var alertContainer: AlertContainer?

    init(passion: OPassion) {
        self.passion = passion
    }

    func addRecord() {
        alertContainer = AlertContainer(alert: Alert(
            title: Text("Add a new Record"),
            message: Text("You are adding a new record for today in the passion \"\(passion.name)\", do you want to proceed?"),
            primaryButton: .default(Text("Add"), action: { [weak self] in self?.createNewRecord(for: Date()) }),
            secondaryButton: .cancel() { [weak self] in self?.alertContainer = nil }
        ))
    }

    private func createNewRecord(for date: Date) {
        passion.records.append(OPassionRecord(date: date))
    }
}

struct PassionView: View {

    @Environment(\.alerterKey) var alerter

    @StateObject var viewModel: PassionViewModel
    @State var maxValue: Int
    let barColor: Color

    var body: some View {
        VStack(spacing: 8) {
            Text(viewModel.passion.name)
                .font(.body)
                .foregroundStyle(Color.mLightText)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(alignment: .bottom, spacing: 8) {
                MProgressView(
                    value: viewModel.passion.records.count,
                    total: maxValue,
                    color: barColor
                )

                MIconButton(type: .secondary, size: .small, image: Image(systemName: "plus")) {
                    viewModel.addRecord()
                }
            }
        }
        .onChange(of: viewModel.alertContainer) {
            alerter.alert = $0?.alert
        }
    }
}
