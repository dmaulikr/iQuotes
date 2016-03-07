//
//  Network.swift
//  iQuotes
//
//  Created by Kevin Hirsch on 11/02/16.
//  Copyright © 2016 Kevin Hirsch. All rights reserved.
//

import Foundation
import Moya
import ReactiveCocoa
import Moya_SwiftyJSONMapper
import SwiftyJSON
import Result

struct Network {
	
	static private let provider = ReactiveCocoaMoyaProvider<QuoteAPI>()
	
	static func request(target: QuoteAPI) -> SignalProducer<Moya.Response, Moya.Error> {
		return provider
			.request(target)
			.filterSuccessfulStatusCodes()
			.flatMapError { SignalProducer(error: $0).delay(0.5, onScheduler: QueueScheduler()) }
			.retry(3)
			.observeOn(UIScheduler())
	}
	
}