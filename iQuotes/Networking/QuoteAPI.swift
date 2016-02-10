//
//  QuoteAPI.swift
//  iQuotes
//
//  Created by Kevin Hirsch on 10/02/16.
//  Copyright © 2016 Kevin Hirsch. All rights reserved.
//

import Moya

enum QuoteAPI {
	
	case RandomQuotes(count: UInt)
	
}

extension QuoteAPI: TargetType {
	
	var baseURL: NSURL { return NSURL(string: "http://quotesondesign.com/wp-json/posts")! }
	
	var path: String {
		switch self {
		case .RandomQuotes(_):
			return ""
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .RandomQuotes(_):
			return .GET
		}
	}
	
	var parameters: [String: AnyObject]? {
		switch self {
		case .RandomQuotes(let count):
			return [
				"filter[orderby]": "rand",
				"filter[posts_per_page]": count
			]
		}
	}
	
	var sampleData: NSData {
		switch self {
		case .RandomQuotes(_):
			return "[{\"ID\":2379,\"title\":\"Ricardo Zea\",\"content\":\"<p>Learning Web Design is like playing video games: You start small and build your character as you progress, then you beat the boss, literally.</p>\n\",\"link\":\"http://quotesondesign.com/ricardo-zea/\",\"custom_meta\":{\"Source\":\"<a href=\\\"https://twitter.com/ricardozea/status/675150834108354561\\\">tweet</a>\"}}]"
				.dataUsingEncoding(NSUTF8StringEncoding)!
		}
	}
	
}
