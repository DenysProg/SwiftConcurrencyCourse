//
//  TaskBootcamp.swift
//  SwiftConcurrency
//
//  Created by Denys Nikolaichuk on 13.06.2023.
//

import SwiftUI

class TaskBootcampVieModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetch() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        
//        for x in array {
//            try Task.checkCancellation()
//        }
        
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            
            await MainActor.run(body: {
                self.image = UIImage(data: data)
            })
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetch2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            
            await MainActor.run(body: {
                self.image2 = UIImage(data: data)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct TaskBootcampHomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("CLICK ME!") {
                    TaskBootcamp()
                }
            }
        }
    }
}

struct TaskBootcamp: View {
    @StateObject private var viewModel = TaskBootcampVieModel()
    @State private var fetchImageTask: Task<(), Never>? = nil
    
    var body: some View {
        VStack(spacing: 40) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            if let image = viewModel.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await viewModel.fetch()
        }
        
//        .onDisappear {
//            fetchImageTask?.cancel()
//        }
//
//        .onAppear {
//            self.fetchImageTask = Task {
//                print(Thread.current)
//                print(Task.currentPriority)
//                await viewModel.fetch()
//
//            }
            
            
//
//            Task {
//                print(Thread.current)
//                print(Task.currentPriority)
//                await viewModel.fetch2()
//            }
            
//            Task(priority: .low) {
//                print("Low: \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .medium) {
//                print("medium: \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .high) {
////                try? await Task.sleep(nanoseconds: 2_000_000_000)
//                await Task.yield()
//                print("high: \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .background) {
//                print("background: \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .utility) {
//                print("utility: \(Thread.current) : \(Task.currentPriority)")
//            }
            
//            Task(priority: .userInitiated) {
//                print("userInitiated: \(Thread.current) : \(Task.currentPriority)")
//
//
//                // get the same from perent
//                Task {
//                    print("userInitiated: \(Thread.current) : \(Task.currentPriority)")
//                }
//
//                // detached from perent
//                Task.detached {
//                    print("userInitiated detached: \(Thread.current) : \(Task.currentPriority)")
//                }
//            }
            
            
            
//        }
    }
}

struct TaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TaskBootcamp()
    }
}
