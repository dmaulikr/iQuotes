//
//  Quote.swift
//  iQuotes
//
//  Created by Kevin Hirsch on 9/02/16.
//  Copyright © 2016 Kevin Hirsch. All rights reserved.
//

import Foundation

typealias Rating = UInt

enum QuoteError: ErrorType {
	
	case MissingContent
	case MissingAuthor
	case IncorrectRating(String)
	
}

struct Quote {
	
	let content: String
	let author: String
	var rating: Rating
	
	init(content: String, author: String, rating: Rating = 0) throws {
		guard !content.isEmpty else { throw QuoteError.MissingContent }
		guard !author.isEmpty else { throw QuoteError.MissingAuthor }
		
		self.content = content
		self.author = author
		self.rating = rating
		
		try updateRating(rating)
	}
	
	mutating func updateRating(rating: Rating) throws {
		guard rating >= 0 && rating <= 5 else {
			throw QuoteError.IncorrectRating("Rating must be between 0 and 5.")
		}
		
		self.rating = rating
	}
	
}