//
//  GlobalActorBootcamp.swift
//  SwiftConcurrency
//
//  Created by Denys Nikolaichuk on 13.07.2023.
//

import SwiftUI

@globalActor struct MyFirstGlobalActor { // final class
    static var shared = MyNewDataManager()
}

actor MyNewDataManager {
    
    func getDataFromDatabase() -> [String] {
        return ["One", "Two", "Tree", "Four"]
    }
}

class GlobalActorBootcampViewModel: ObservableObject {
    @MainActor @Published var dataArray: [String] = []
    let manager = MyFirstGlobalActor.shared
    
    
    @MyFirstGlobalActor func getData() {
        Task {
            let data = await manager.getDataFromDatabase()
            await MainActor.run(body: {
                self.dataArray = data
            })
        }
    }
}

struct GlobalActorBootcamp: View {
    @StateObject private var viewModel = GlobalActorBootcampViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task {
            await viewModel.getData()
        }
    }
}

struct GlobalActorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GlobalActorBootcamp()
    }
}
