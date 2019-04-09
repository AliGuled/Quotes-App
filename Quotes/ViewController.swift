//
//  ViewController.swift
//  Quotes
//
//  Created by Guled Ali on 4/2/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController,QuoteDelegate {
    
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var newQuoteButton: UIButton!
    func quoteFetched(quote: Quote) {
        DispatchQueue.main.async {
            let quoteText = "<p>\(quote.text)<p><em> - \n\(quote.author)</em></p>"
            let data = Data(quoteText.utf8)
        
        
        
            
            let attributedString = try? NSAttributedString(data: data, options:[.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            self.quoteTextView.font = UIFont.boldSystemFont(ofSize: 50)
        self.quoteTextView.attributedText = attributedString
        print(quote)
    }
    }
    
    func quoteFetchError(because quoteError: QuoteError) {
         let alert = UIAlertController(title: "Error", message: "Error fetching quote. \(quoteError.message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        newQuoteButton.isEnabled = true
    }
    
    
    let quoteFetcher = QuoteFetcher()

    override func viewDidLoad() {
        super.viewDidLoad()
        quoteFetcher.quoteDelegate = self
       quoteFetcher.fetchRandomQuote()
        newQuoteButton.isEnabled = true
        quoteTextView.font = UIFont.boldSystemFont(ofSize: 50)
    }
    

    @IBAction func getQuote(_ sender: UIButton) {
        quoteFetcher.fetchRandomQuote()
        newQuoteButton.isEnabled = true
        
    }
    
}

