//
//  StructClassActorBootcamp.swift
//  SwiftConcurrency
//
//  Created by Denys Nikolaichuk on 05.07.2023.
//


/*
 Links:
 https://blog.onewayfirst.com/ios/posts/2019-03-19-class-vs-struct/
 https://stackoverflow.com/questions/24217586/structure-vs-class-in-swift-language
 https://medium.com/@vinayakkini/swift-basics-struct-vs-class-31b44ade28ae
 https://stackoverflow.com/questions/24217586/structure-vs-class-in-swift-language/59219141#59219141
 https://stackoverflow.com/questions/27441456/swift-stack-and-heap-understanding
 https://stackoverflow.com/questions/24232799/why-choose-struct-over-class/24232845
 https://www.backblaze.com/blog/whats-the-diff-programs-processes-and-threads/
 
 VALUES TYPES:
  - Struct, Enum, String, Int, ect
  - Stored in the Stack
  - Faster
  - Thread safe!
  - When you assign or pass value type a new copy of data is created
 
 REFERENCE TYPES:
  - Class, Function, Actor
  - Stored in the Heap
  - Slower, but synchronized
  - NOT Thread safe
  - When you assign or pass reference type a new reference to original instance will be created (pointer)
 
 ----------------------------
 
 STACK:
  - Stored Value types
  - Variables allocated on the stack are stored directly to the memory, and access to this memory is very fast
  - Each thread has it's own stack!
 
 HEAP:
  - Stores Reference types
  - Shared across threads
 
 ------------------------------
 
 STRUCT:
  - Based on VALUES
  - Can be mutated
  - Stored in the Stack!
 
 CLASS:
 - Based on REFERENCES (INSTANCES)
 - Stored in the Heap !
 - Inherit form other classes
 
 ACTOR:
  - Same as Class, but thread safe!
 
 ---------------------------------
 Structs: Data Models, Views
 Classes: View Models, Managers
 Actors: Shared "Manager" and "Data Store"
 
 */

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

extension StructClassActorBootcamp {
    private func runTest() {
        
        structTest1()

        printDivider()

        classTest1()
        printDivider()
        actorTest1()
        
        
        
//        structTest2()
//
//        printDivider()
//
//        classTest2()
    }
    
    private func structTest1() {
        print("structTest1")
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
    
    private func printDivider() {
        print("""
        
        ------------------------------------
        
        """)
    }
    
    private func classTest1() {
        print("classTest1")
        let objectA = MyClass(title: "Strating title")
        print("ObjectA: ", objectA.title)
        
        print("Pass the REFERENCE of objectA to objectB")
        var objectB = objectA
        print("ObjectB: ", objectA.title)
        
        objectB.title = "Second title"
        print("ObjectB title changed: ")

        print("ObjectA: ", objectA.title)
        print("ObjectB: ", objectB.title)
    }
    
    
    private func actorTest1() {
        Task {
            print("acotrTest1")
            let objectA = MyActor(title: "Strating title")
            await print("ObjectA: ", objectA.title)
            
            print("Pass the REFERENCE of objectA to objectB")
            var objectB = objectA
            await print("ObjectB: ", objectA.title)
            
            await objectB.updateTitle(newTitle: "Second title")
            print("ObjectB title changed: ")
            
            await print("ObjectA: ", objectA.title)
            await print("ObjectB: ", objectB.title)
        }
    }
}

struct MyStruct {
    var title: String
}

// Immutable struct
struct CustomStruct {
    let title: String
    
    func updateTitle(newTitle: String) -> CustomStruct {
        CustomStruct(title: newTitle)
    }
}

struct MutatingStruct {
    private(set) var title: String
    
    init(title: String) {
        self.title = title
    }
    
    mutating func updateTitle(newTitle: String) {
        title = newTitle
    }
}

extension StructClassActorBootcamp {
    
    private func structTest2() {
        print("structTest2")
        
        print("struct1")
        var struct1 = MyStruct(title: "Title1")
        print("Struct1:", struct1.title)
        struct1.title = "Title2"
        print("Struct1:", struct1.title)
        
        print("struct2")
        var struct2 = CustomStruct(title: "Title1")
        print("Struct2:", struct2.title)
        struct2 = CustomStruct(title: "Title2")
        print("Struct2:", struct2.title)
        
        print("struct3")
        var struct3 = CustomStruct(title: "Title1")
        print("Struct3:", struct3.title)
        struct3 = struct3.updateTitle(newTitle: "Title2")
        print("Struct3:", struct3.title)
        
        print("struct4")
        var struct4 = MutatingStruct(title: "Title1")
        print("Struct4:", struct4.title)
        struct4.updateTitle(newTitle: "Title2")
        print("Struct4:", struct4.title)
    }
}

class MyClass {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
     func updateTitle(newTitle: String) {
        title = newTitle
    }
}

actor MyActor {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
     func updateTitle(newTitle: String) {
        title = newTitle
    }
}

extension StructClassActorBootcamp {
    
    private func classTest2() {
        print("classTest2")
        
        print("class1")
        let class1 = MyClass(title: "Title1")
        print("Class1: ", class1.title)
        class1.title = "Title2"
        print("Class1: ", class1.title)
        
        print("class2")
        let class2 = MyClass(title: "Title1")
        print("Class2: ", class2.title)
        class2.updateTitle(newTitle: "Title2")
        print("Class2: ", class2.title)
    }
}
