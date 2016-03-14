//
//  iQuotesTests.swift
//  iQuotesTests
//
//  Created by Kevin Hirsch on 8/02/16.
//  Copyright © 2016 Kevin Hirsch. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON

@testable import iQuotes

class QuoteSpec: QuickSpec {
	
	override func spec() {
		describe("a quote") {
			context("initialization") {
				it("should work with correct values") {
					let quote = try! Quote(content: "Keep it simple and stupid or KISS", author: "Kevin")
					
					expect(quote.content) == "Keep it simple and stupid or KISS"
					expect(quote.author) == "Kevin"
				}
				
				context("should fail with empty") {
					it("content") {
						expect { try Quote(content: "", author: "Kevin") }
							.to(throwError(QuoteError.MissingContent))
					}
					
					it("author") {
						expect { try Quote(content: "Keep it simple and stupid or KISS", author: "") }
							.to(throwError(QuoteError.MissingAuthor))
					}
				}
				
				context("with JSON") {
					func createQuote(author author: String?, content: String?, shouldSucceed: Bool) {
						var json = JSON([:])

						if let author = author { json["title"] = JSON(author) }
						if let content = content { json["content"] = JSON(content) }
						
						let quote = Quote(jsonData: json)
						
						if shouldSucceed {
							expect(quote).toNot(beNil())
						} else {
							expect(quote).to(beNil())
						}
					}
					
					it("should work with correct random (A) JSON") {
						createQuote(author: "Kevin", content: "Some quote content", shouldSucceed: true)
					}
					
					it("should work with correct random (B) JSON") {
						createQuote(author: "Gérard", content: "Another quote!", shouldSucceed: true)
					}
					
					it("should failed with wrong keys in JSON") {
						let json = JSON(["key": "value"])
						let quote = Quote(jsonData: json)
						
						expect(quote).to(beNil())
					}
					
					it("should failed with empty values in JSON") {
						createQuote(author: "", content: "", shouldSucceed: false)
					}
					
					it("should failed with missing title key in JSON") {
						createQuote(author: nil, content: "To be or not to be?", shouldSucceed: false)
					}
					
					it("should failed with missing content key in JSON") {
						createQuote(author: "Juan", content: nil, shouldSucceed: false)
					}
					
					it("should failed with no keys in JSON") {
						createQuote(author: nil, content: nil, shouldSucceed: false)
					}
				}
			}
			
			context("rating") {
				var quote: Quote!
				
				beforeEach {
					quote = try! Quote(content: "Keep it simple and stupid or KISS", author: "Kevin")
				}
				
				func succeedsToRate(rating: Rating) {
					expect { try quote.updateRating(rating) }
						.toNot(throwError())
				}
				
				func failsToRate(rating: Rating) {
					expect { try quote.updateRating(rating) }
						.to(throwError(QuoteError.IncorrectRating("Rating must be between 0 and 5.")))
				}
				
				it("should work with correct value") {
					for rate: Rating in 0...5 {
						succeedsToRate(rate)
					}
				}
				
				it("should fail with too high value") {
					failsToRate(6)
					failsToRate(20)
					failsToRate(Rating.max)
				}
			}
		}
	}
	
}
