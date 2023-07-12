//
//  StructClassActorBootcamp.swift
//  SwiftConcurrency
//
//  Created by Denys Nikolaichuk on 05.07.2023.
//

import SwiftUI

struct StructClassActorBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                runTest()
            }
    }
}

struct StructClassActorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        StructClassActorBootcamp()
    }
}

struct MyStruct {
    var title: String
}

extension StructClassActorBootcamp {
    private func runTest() {
        print("Test srarted")
        structTest1()
    }
    
    private func structTest1() {
        let objectA = MyStruct(title: "Strating title")
        print("ObjectA: ", objectA.title)
        
        print("Pass the Values of objectA to objectB")
        var objectB = objectA
        print("ObjectB: ", objectA.title)
        
        objectB.title = "Second title"
        print("ObjectB title changed: ")
        
        print("ObjectA: ", objectA.title)
        print("ObjectB: ", objectB.title)
    }
}
