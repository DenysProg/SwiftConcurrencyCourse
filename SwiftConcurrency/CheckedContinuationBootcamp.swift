//
//  CheckedContinuationBootcamp.swift
//  SwiftConcurrency
//
//  Created by Denys Nikolaichuk on 05.07.2023.
//

import SwiftUI

class CheckedContinuationBootcampNetworkManager {
    func getData(url: URL) async throws -> Data {
        do {
           let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw error
        }
        
    }
    
    func getData2(url: URL) async throws -> Data {
        return try await withCheckedThrowingContinuation({ continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
            .resume()
        })
    }
    
    private func getHeartImageFromDatabase(complitionHandler: @escaping (_ image: UIImage) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            complitionHandler(UIImage(systemName: "heart.fill")!)
        }
    }
    
    func getHeartImageFromDataBase() async -> UIImage {
        return await withCheckedContinuation({ continuation in
            getHeartImageFromDatabase { image in
                continuation.resume(returning: image)
            }
        })
    }
}

class CheckedContinuationBootcampViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let networkManager = CheckedContinuationBootcampNetworkManager()
    
    func getImage() async {
        guard let url = URL(string: "https://picsum.photos/300") else { return }
        
        do {
            let data = try await networkManager.getData2(url: url)
            if let image = UIImage(data: data) {
                await MainActor.run(body: {
                    self.image = image
                })
            }
        } catch {
            print(error)
        }
    }
    
    func getHeartImage() async {
        self.image = await networkManager.getHeartImageFromDataBase()
    }
}

struct CheckedContinuationBootcamp: View {
    @StateObject private var viewModel = CheckedContinuationBootcampViewModel()
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
//            await viewModel.getImage()
            await viewModel.getHeartImage()
        }
    }
}

struct CheckedContinuationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CheckedContinuationBootcamp()
    }
}
