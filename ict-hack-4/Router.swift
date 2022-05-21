//
//  Router.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 21.05.2022.
//

import UIKit

class Router {
	
	private let window: UIWindow
	
	init(window: UIWindow) {
		self.window = window
	}
	
	func createAuthScreen() -> EnterPasswordViewController {
		let screen = EnterPasswordViewController(router: self)
		
		return screen
	}
	
	func switchToMainScreen() {
		let mainVC = MainViewController()
		window.rootViewController = mainVC
		window.makeKeyAndVisible()
		UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
	}
}
