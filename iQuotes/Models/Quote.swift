//
//  Quote.swift
//  iQuotes
//
//  Created by Kevin Hirsch on 9/02/16.
//  Copyright © 2016 Kevin Hirsch. All rights reserved.
//

import Foundation
import Moya_SwiftyJSONMapper
import SwiftyJSON

public typealias Rating = UInt

public enum QuoteError: ErrorType {
	
	case MissingContent
	case MissingAuthor
	case IncorrectRating(String)
	
}

public struct Quote: ALSwiftyJSONAble {
	
	public let content: String
	public let author: String
	public var rating: Rating
	
	public init(content: String, author: String, rating: Rating = 0) throws {
		guard !content.isEmpty else { throw QuoteError.MissingContent }
		guard !author.isEmpty else { throw QuoteError.MissingAuthor }
		
		self.content = content
		self.author = author
		self.rating = rating
		
		try updateRating(rating)
	}
	
	public init?(jsonData: JSON) {
		guard let
			author = jsonData["title"].string,
			content = jsonData["content"].string
			else { return nil }
		
		try? self.init(content: content, author: author)
	}
	
	public mutating func updateRating(rating: Rating) throws {
		guard rating >= 0 && rating <= 5 else {
			throw QuoteError.IncorrectRating("Rating must be between 0 and 5.")
		}
		
		self.rating = rating
	}
	
}
