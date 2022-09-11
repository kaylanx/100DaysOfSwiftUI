//
//  UnderstandingSwiftsResultType.swift
//  Hot Prospects
//
//  Created by Andy Kayley on 11/09/2022.
//

import SwiftUI

enum UnderstandingSwiftsResultType {

    struct ContentView: View {
        @State private var output = ""

        var body: some View {
            Text(output)
                .task {
                    await fetchReadings()
                }
        }

        private func fetchReadings() async {
            let fetchTask = Task { () -> String in
                let url = URL(string: "https://hws.dev/readings.json")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let readings = try JSONDecoder().decode([Double].self, from: data)
                return "Found \(readings.count) readings"
            }

            let result = await fetchTask.result

//            handleWithDoCatch(result: result)
            handleWithEnum(result: result)

        }

        private func handleWithDoCatch(result: Result<String, Error>) {
            do {
                output = try result.get()
            } catch {
                output = "Error: \(error.localizedDescription)"
            }
        }

        private func handleWithEnum(result: Result<String, Error>) {
            switch result {
                case .success(let string):
                    output = string
                case .failure(let error):
                    output = "Error: \(error.localizedDescription)"
            }
        }
    }
}
