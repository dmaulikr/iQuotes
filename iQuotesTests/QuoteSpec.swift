//
//  iQuotesTests.swift
//  iQuotesTests
//
//  Created by Kevin Hirsch on 8/02/16.
//  Copyright © 2016 Kevin Hirsch. All rights reserved.
//

import Quick
import Nimble
@testable import iQuotes

func succeed() {
	expect(true) == true
}

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
						do {
							_ = try Quote(content: "", author: "Kevin")
							fail()
						} catch QuoteError.MissingContent {
							succeed()
						} catch {
							fail()
						}
					}
					
					it("author") {
						do {
							_ = try Quote(content: "Keep it simple and stupid or KISS", author: "")
							fail()
						} catch QuoteError.MissingAuthor {
							succeed()
						} catch {
							fail()
						}
					}
				}
			}
			
			context("rating") {
				var quote: Quote!
				
				beforeEach {
					quote = try! Quote(content: "Keep it simple and stupid or KISS", author: "Kevin")
				}
				
				func succeedsToRate(rating: Rating) {
					do {
						try quote.updateRating(rating)
						succeed()
					} catch {
						fail()
					}
				}
				
				func failsToRate(rating: Rating) {
					do {
						try quote.updateRating(rating)
						fail()
					} catch QuoteError.IncorrectRating(let error) {
						expect(error) == "Rating must be between 0 and 5."
					} catch {
						fail()
					}
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
