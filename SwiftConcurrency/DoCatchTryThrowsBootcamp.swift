//
//  DoCatchTryThrowsBootcamp.swift
//  SwiftConcurrency
//
//  Created by Denys Nikolaichuk on 02.06.2023.
//

import SwiftUI

// do-catch
// try
// throws

class DoCatchTryThrowsBootcampDataManager {
    let isActive: Bool = true
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("New Text", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("New Text")
        } else {
            return .failure(URLError(.badURL))
        }
    }
    
    func getTitle3() throws -> String {
//        if isActive {
//            return "New Text"
//        } else {
            throw URLError(.badServerResponse)
//        }
    }
    
    func getTitle4() throws -> String {
        if isActive {
            return "Final Text"
        } else {
            throw URLError(.badServerResponse)
        }
    }
}

class DoCatchTryThrowsBootcampViewModel: ObservableObject {
    @Published var text: String = "Starting text."
    let manager = DoCatchTryThrowsBootcampDataManager()
    
    func fetchTitle() {
        /*
         let returnedValue = manager.getTitle()
         if let newTitle = returnedValue.title {
         self.text = newTitle
         } else if let error = returnedValue.error {
         self.text = error.localizedDescription
         }
         */
        
        /*
        let result = manager.getTitle2()
        
        switch result {
        case .success(let newTitle):
            self.text = newTitle
        case .failure(let error):
            self.text = error.localizedDescription
        }
         */
        
        let newTitle = try? manager.getTitle3()
        
        if let newTitle = newTitle {
            self.text = newTitle
        }
        

        
        do {
            let newTitle = try? manager.getTitle3()
            
            if let newTitle = newTitle {
                self.text = newTitle
            }

            let finalText = try manager.getTitle4()
            self.text = finalText
        } catch {
            self.text = error.localizedDescription
        }
    }
}

struct DoCatchTryThrowsBootcamp: View {
    @StateObject private var viewModel = DoCatchTryThrowsBootcampViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(.blue)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

struct DoCatchTryThrowsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DoCatchTryThrowsBootcamp()
    }
}
