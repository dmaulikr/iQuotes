//
//  ViewController.swift
//  iQuotes
//
//  Created by Kevin Hirsch on 8/02/16.
//  Copyright © 2016 Kevin Hirsch. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Moya

class ViewController: UIViewController {
	
	@IBOutlet
	var label: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		Network
			.request(.RandomQuotes(count: 10))
			.on(started: { self.label.text = "Loading..." })
			.mapArray(Quote)
			.on(failed: { _ in self.label.text = "Error" })
			.map { $0.randomItem().content }
			.observeOn(UIScheduler())
			.startWithNext { self.label.text = $0 }
	}
	
}
