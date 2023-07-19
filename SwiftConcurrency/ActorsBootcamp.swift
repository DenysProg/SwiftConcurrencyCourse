//
//  ActorsBootcamp.swift
//  SwiftConcurrency
//
//  Created by Denys Nikolaichuk on 13.07.2023.
//

import SwiftUI

// 1. What is the problem that actor are solving?
// 2. How was this problem solved prior to actors?
// 3. Actros can solve the problem!

class MyDataManager {
    static let instance = MyDataManager()
    private init() {}
    private let queue = DispatchQueue(label: "com.MyApp.MyDataManager")
    
    var data: [String] = []
    
    func getRandomData(completionHandler: @escaping(_ title: String?) -> Void) {
        
        queue.async {
            self.data.append(UUID().uuidString)
            print(Thread.current)
            completionHandler(self.data.randomElement())
        }
    }
}

actor MyActorDataManager {
    static let instance = MyActorDataManager()
    private init() {}
    
    var data: [String] = []
    
    nonisolated let myRendomText = "daljdsnlkasndlkjalks"
    
    func getRandomData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return data.randomElement()
    }
    
    nonisolated func getSavedData() -> String {
        return "NEW DATA"
    }
}

struct HomeView: View {
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    //    let manager = MyDataManager.instance
    let manager = MyActorDataManager.instance
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onAppear {
            let newString = manager.getSavedData()
            let someNewString = manager.myRendomText
        }
        
        .onReceive(timer) { _ in
//            Task {
//                if let data = await manager.getRandomData() {
//                    await MainActor.run(body: {
//                        self.text = data
//                    })
//                }
//            }
            
            
//            DispatchQueue.global(qos: .background).async {
//                manager.getRandomData { title in
//                    if let data = title {
//                        DispatchQueue.main.async {
//                            self.text = data
//                        }
//                    }
//                }
//            }
        }
    }
}

struct BrowseView: View {
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
//    let manager = MyDataManager.instance
    let manager = MyActorDataManager.instance
    
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
//            Task {
//                if let data = await manager.getRandomData() {
//                    await MainActor.run(body: {
//                        self.text = data
//                    })
//                }
//            }
            
            
//            DispatchQueue.global(qos: .background).async {
//                manager.getRandomData { title in
//                    if let data = title {
//                        DispatchQueue.main.async {
//                            self.text = data
//                        }
//                    }
//                }
//            }
        }
    }
}

struct ActorsBootcamp: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            BrowseView()
                .tabItem {
                    Label("Home", systemImage: "magnifyingglass")
                }
        }
    }
}

struct ActorsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ActorsBootcamp()
    }
}
