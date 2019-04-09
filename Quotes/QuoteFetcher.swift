//
//  QuoteFetcher.swift
//  Quotes
//
//  Created by Guled Ali on 4/2/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import Foundation

class QuoteError: Error {
    let message: String
    init(message: String) {
        self.message = message
    }
}

class QuoteFetcher {
    
    var quoteDelegate: QuoteDelegate?
    
    
    let urlString = "https://quotesondesign.com/wp-json/posts?filter%5Borderby%5D=rand&filter%5Bposts_per_page%5D=1"
    
    func fetchRandomQuote() {
        
        guard let delegate = quoteDelegate else {
            print("Warning -  no delegate set")
            return
        }
        let url = URL(string: urlString)
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url!,completionHandler: {(data, response,error ) in
            
            if let error = error {
                delegate.quoteFetchError(because: QuoteError(message: error.localizedDescription))
            }
            if let quoteData = data {
            let decoder = JSONDecoder()
            if let data = data {
                let quotes = try? decoder.decode([Quote].self, from: data)
                if let randomQuote = quotes?.first {
                    delegate.quoteFetched(quote: randomQuote)
                } else {
                    delegate.quoteFetchError(because: QuoteError(message: "No quotes returned"))
                }
                
            } else {
                delegate.quoteFetchError(because: QuoteError(message: "Unable to decode response from quote server"))
            }
            
            }
            
            
        })
        task.resume()
    }
}
