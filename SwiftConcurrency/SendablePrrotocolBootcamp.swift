//
//  SendablePrrotocolBootcamp.swift
//  SwiftConcurrency
//
//  Created by Denys Nikolaichuk on 18.07.2023.
//

import SwiftUI

actor CurrentUserManager {
    let manager = CurrentUserManager()
    
    func updateDatabase(userInfo: MyClassUserInfo) {
        
    }
}

struct MyUserInfo: Sendable {
    let name: String
}

final class MyClassUserInfo: @unchecked Sendable {
    private var name: String
    let queue = DispatchQueue(label: "com.My.app")
    
    init(name: String) {
        self.name = name
    }
    
    func updateName(name: String) {
        queue.async {
            self.name = name
        }
    }
}

class SendablePrrotocolBootcampViewModel: ObservableObject {
    let manager = CurrentUserManager()
    
    func updateCurrentUserInfo() async {
        let info = MyClassUserInfo(name: "User info")
        
        await manager.updateDatabase(userInfo: info)
    }
}

struct SendablePrrotocolBootcamp: View {
    @StateObject private var viewModel = SendablePrrotocolBootcampViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
           
    }
}

struct SendablePrrotocolBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SendablePrrotocolBootcamp()
    }
}
