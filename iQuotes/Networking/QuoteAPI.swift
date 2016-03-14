//
//  QuoteAPI.swift
//  iQuotes
//
//  Created by Kevin Hirsch on 10/02/16.
//  Copyright © 2016 Kevin Hirsch. All rights reserved.
//

import Moya

public enum QuoteAPI {
	
	case RandomQuotes(count: UInt)
	
}

extension QuoteAPI: TargetType {
	
	public var baseURL: NSURL { return NSURL(string: "http://quotesondesign.com/wp-json/posts")! }
	
	public var path: String {
		switch self {
		case .RandomQuotes(_):
			return ""
		}
	}
	
	public var method: Moya.Method {
		switch self {
		case .RandomQuotes(_):
			return .GET
		}
	}
	
	public var parameters: [String: AnyObject]? {
		switch self {
		case .RandomQuotes(let count):
			return [
				"filter[orderby]": "rand",
				"filter[posts_per_page]": count
			]
		}
	}
	
	public var sampleData: NSData {
		switch self {
		case .RandomQuotes(_):
			return "[{\"ID\":2379,\"title\":\"Ricardo Zea\",\"content\":\"<p>Learning Web Design is like playing video games: You start small and build your character as you progress, then you beat the boss, literally.</p>\n\",\"link\":\"http://quotesondesign.com/ricardo-zea/\",\"custom_meta\":{\"Source\":\"<a href=\\\"https://twitter.com/ricardozea/status/675150834108354561\\\">tweet</a>\"}}]"
				.dataUsingEncoding(NSUTF8StringEncoding)!
		}
	}
	
}
