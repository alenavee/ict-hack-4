//
//  NewDiaryEntryViewController.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 21.05.2022.
//

import UIKit

class NewDiaryEntryViewController: UIViewController {
	let table = UITableView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		registers()
		setupViews()
	}
	
	private func setupViews() {
		view.backgroundColor = AppColors.mainBackground
		table.backgroundColor = AppColors.mainBackground
		table.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
		table.separatorStyle = .none
		
		view.addSubview(table)
		table.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .bottom)
		table.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.bottomAnchor).isActive = true
	}
	
	private func registers() {
		table.dataSource = self
		
		table.register(NewNoteTableViewCell.self, forCellReuseIdentifier: String(describing: NewNoteTableViewCell.self))
	}
}

extension NewDiaryEntryViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewNoteTableViewCell.self), for: indexPath) as? NewNoteTableViewCell else {
			return UITableViewCell()
		}
		cell.delegate = self
		
		return cell
	}
	
	
}

extension NewDiaryEntryViewController: NewNoteTableViewCellDelegate {
	func textChanged() {
		DispatchQueue.main.async { [weak table] in
			table?.beginUpdates()
			table?.endUpdates()
		}
	}
}
