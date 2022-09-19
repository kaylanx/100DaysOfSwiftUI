//
//  ProspectsView.swift
//  Hot Prospects
//
//  Created by Andy Kayley on 14/09/2022.
//

import SwiftUI
import UserNotifications
import CodeScanner

struct ProspectsView: View {

    @State private var sortOption = SortOptions.name

    enum FilterType {
        case none, contacted, uncontacted
    }
    let filter: FilterType

    @EnvironmentObject private var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSortOptions = false

    private var title: String {
        switch filter {
            case .none:
                return "Everyone"
            case .contacted:
                return "Contacted people"
            case .uncontacted:
                return "Uncontacted people"
        }
    }

    private var filteredProspects: [Prospect] {
        switch filter {
            case .none:
                return prospects.all(sortedBy: sortOption)
            case .contacted:
                return prospects.contacted(sortedBy: sortOption)
            case .uncontacted:
                return prospects.uncontacted(sortedBy: sortOption)
        }
    }

    private func contactedImage(for prospect: Prospect) -> some View {
        Group {
            if prospect.isContacted && filter == .none {
                Spacer()
                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                    .foregroundColor(.green)
            } else {
                EmptyView()
            }
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        contactedImage(for: prospect)
                    }
                    .swipeActions {
                        if prospect.isContacted {
                            markUncontactedButton(for: prospect)
                        } else {
                            markContactedButton(for: prospect)
                            remindToContactButton(for: prospect)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button {
                    isShowingScanner = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }

                Button {
                    isShowingSortOptions = true
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down.square")
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(
                    codeTypes: [.qr],
                    simulatedData: "\(UUID().uuidString)Andy Kayley\n\(UUID().uuidString)100days@kayley.name",
                    completion: handleScan
                )
            }
            .confirmationDialog("Sort by", isPresented: $isShowingSortOptions) {
                Button("Name") {
                    withAnimation {
                        sortOption = .name
                    }
                }
                Button("Most recent") {
                    withAnimation {
                        sortOption = .dateAdded
                    }
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Select a sort option")
            }
        }
    }

    private func markUncontactedButton(for prospect: Prospect) -> some View {
        Button {
            prospects.toggleContacted(for: prospect)
        } label: {
            Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
        }
        .tint(.blue)
    }

    private func markContactedButton(for prospect: Prospect) -> some View {
        Button {
            prospects.toggleContacted(for: prospect)
        } label: {
            Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
        }
        .tint(.green)
    }

    private func remindToContactButton(for prospect: Prospect) -> some View {
        Button {
            addNotification(for: prospect)
        } label: {
            Label("Remind Me", systemImage: "bell")
        }
        .tint(.orange)
    }

    private func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
            case .success(let result):
                let details = result.string.components(separatedBy: "\n")
                guard details.count == 2 else { return }

                let person = Prospect()
                person.name = details[0]
                person.emailAddress = details[1]

                prospects.add(prospect: person)
            case .failure(let error):
                print("Scanning failed: \(error.localizedDescription)")
        }
    }

    private func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = .default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }

        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
