//
//  RefreshableBootcamp.swift
//  SwiftConcurrency
//
//  Created by Denys Nikolaichuk on 20.07.2023.
//

import SwiftUI

final class RefreshableDataService {
    func getData() async throws -> [String] {
        ["Apple", "Orange", "Banana"].shuffled()
    }
}

@MainActor
final class RefreshableBootcampViewModel: ObservableObject {
    @Published private(set) var items: [String] = []
    let service = RefreshableDataService()
    
    func loadData() async {
        do {
            items = try await service.getData()
        } catch {
            print(error)
        }
    }
}

struct RefreshableBootcamp: View {
    @StateObject private var viewModel = RefreshableBootcampViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.items, id: \.self) { item in
                        Text(item)
                            .font(.headline)
                    }
                }
            }
            .refreshable {
                await viewModel.loadData()
            }
            .navigationTitle("Refreshable")
            .task {
                await viewModel.loadData()
            }
        }
    }
}

struct RefreshableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableBootcamp()
    }
}
