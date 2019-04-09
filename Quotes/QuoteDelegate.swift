//
//  File.swift
//  Quotes
//
//  Created by Guled Ali on 4/2/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import Foundation

protocol QuoteDelegate {
    func quoteFetched(quote: Quote)
    func quoteFetchError(because quoteError: QuoteError)
    
}
