//
//  WikipediaViewController.swift
//  Toxic Botanica
//
//  Created by Katherine Whitmoyer on 11/23/24.
//  Note: This file uses extensive portions of the tutorial found here:
//  https://www.hackingwithswift.com/books/ios-swiftui/downloading-data-from-wikipedia

import SwiftUI

struct WikipediaView: View {
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    func fetchExtracts() async {
        let urlString = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exlimit=max&explaintext&titles=heracleum_mantegazzianum"
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            loadingState = .failed
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted { $0.title < $1.title }
            loadingState = .loaded
        } catch {
            loadingState = .failed
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if loadingState == .loading {
                    Text("Loading...")
                        .onAppear {
                            Task {
                                await fetchExtracts()
                            }
                        }
                } else if loadingState == .loaded {
                    ScrollView {
                        ForEach(pages, id: \.pageid) { page in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(page.title)
                                    .font(.headline)
                                Text(page.extract ?? "No description available")
                                    .italic()
                            }
                            .padding()
                            Divider()
                        }
                    }
                } else if loadingState == .failed {
                    Text("Failed to load data. Please try again.")
                }
            }
            .navigationTitle("Plant Information")
        }
    }
    

    struct Result: Codable {
        let query: Query
    }
    
    struct Query: Codable {
        let pages: [Int: Page]
    }
    
    struct Page: Codable {
        let pageid: Int
        let title: String
        let extract: String?
    }
}

struct WikipediaView_Previews: PreviewProvider {
    static var previews: some View {
        WikipediaView()
    }
}
