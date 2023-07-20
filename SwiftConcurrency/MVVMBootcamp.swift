//
//  MVVMBootcamp.swift
//  SwiftConcurrency
//
//  Created by Denys Nikolaichuk on 18.07.2023.
//

import SwiftUI

final class MyManagerClass {
    func getData() async throws -> String {
        "Some Data!"
    }
}

actor MyManagerActor {
    func getData() async throws -> String {
        "Some Data!"
    }
}
// @MainActor
final class MVVMBootcampViewModel: ObservableObject {
    let managerClass = MyManagerClass()
    let managerActor = MyManagerActor()
    
    @MainActor @Published private(set) var myData: String = "Starting text"
    private var tasks: [Task<Void, Never>] = []
    
    func cancelTasks() {
        tasks.forEach { $0.cancel() }
        tasks = []
    }
    
    @MainActor
    func onCallToActionButtonPressed() {
        let task = Task { // @MainActor in
            do {
                myData = try await managerClass.getData()
            } catch {
                print(error)
            }
        }
        tasks.append(task)
    }
}

struct MVVMBootcamp: View {
    @StateObject private var viewModel = MVVMBootcampViewModel()
    
    var body: some View {
        VStack {
            Button(viewModel.myData) {
                viewModel.onCallToActionButtonPressed()
            }
        }
       
        .onDisappear {
            
        }
    }
}

struct MVVMBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MVVMBootcamp()
    }
}
