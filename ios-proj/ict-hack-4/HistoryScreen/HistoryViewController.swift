//
//  HistoryViewController.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 21.05.2022.
//

import UIKit

class HistoryViewController: UIViewController {
	
	private let dateFormatter: DateFormatter = {
		let dateFormatterDate = DateFormatter()
		dateFormatterDate.dateFormat = "dd/MM/yyyy"
		
		return dateFormatterDate
	}()
	
	private let table = UITableView()
	
	private let storage = Storage.shared
	
	init() {
		super.init(nibName: nil, bundle: nil)
		setupViews()
		table.delegate = self
		table.dataSource = self
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		table.reloadData()
	}
	
	private func setupViews() {
		view.backgroundColor = AppColors.mainBackground
		table.backgroundColor = AppColors.mainBackground
		table.register(HistoryTableViewCell.self, forCellReuseIdentifier: String(describing: HistoryTableViewCell.self))
		
		view.addSubview(table)
		table.autoPinEdgesToSuperviewSafeArea(with: .zero)
		
		table.separatorStyle = .none
	}
}

extension HistoryViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let oldRecord = storage.history[indexPath.item]
		let recordController = NewDiaryEntryViewController()
		recordController.data = oldRecord.blocks
		recordController.title = "Запись от \(dateFormatter.string(from: oldRecord.date))"
		navigationController?.pushViewController(recordController, animated: true)
		recordController.reloadData()
	}
}

extension HistoryViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		Storage.shared.history.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HistoryTableViewCell.self), for: indexPath) as? HistoryTableViewCell else {
			return UITableViewCell()
		}
		let date = storage.history[indexPath.item].date
		cell.configure(date)
		cell.selectionStyle = .none
		
		return cell
	}

}
