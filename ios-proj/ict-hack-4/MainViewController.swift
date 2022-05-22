//
//  MainViewController.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 21.05.2022.
//

import UIKit

class MainViewController: UITabBarController {
	
	init() {
		super.init(nibName: nil, bundle: nil)
		configureViewControllers()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tabBar.backgroundColor = .white
	}
	
	private func configureViewControllers() {
		let tabOne = UINavigationController(rootViewController: NewDiaryEntryViewController())
		let tabOneBarItem = UITabBarItem(title: "Новая запись", image: UIImage(named: AppImageNames.create), tag: 0)
		tabOne.tabBarItem = tabOneBarItem
		
		let tabTwo = UINavigationController(rootViewController: HistoryViewController())
		let tabTwoBarItem = UITabBarItem(title: "История", image: UIImage(named: AppImageNames.history), tag: 1)
		tabTwo.tabBarItem = tabTwoBarItem
		
		viewControllers = [tabOne, tabTwo]
	}


}
