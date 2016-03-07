//
//  ArrayExtensions.swift
//  iQuotes
//
//  Created by Kevin Hirsch on 7/03/16.
//  Copyright © 2016 Kevin Hirsch. All rights reserved.
//

import Foundation

extension Array {
	
	func randomItem() -> Element {
		let index = Int(arc4random_uniform(UInt32(self.count)))
		return self[index]
	}
	
}
