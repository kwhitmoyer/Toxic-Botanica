//
//  WikipediaViewController.swift
//  Toxic Botanica
//
//  Created by Katherine Whitmoyer on 11/26/24.
//

import UIKit

enum LoadingState {
    case loading, loaded, failed
}

class WikipediaViewController : UIViewController{
    private var loadingState = LoadingState.loading
    private var pages = [Page]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
