//
//  NewDiaryEntryViewController.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 21.05.2022.
//

import UIKit

class NewDiaryEntryViewController: UIViewController {
	let table = UITableView()
	private let table = UITableView()
	
	private let predictionModel = PredictionModel()
	
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
		table.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor).isActive = true
	}
	
	private func registers() {
		table.dataSource = self
		table.delaysContentTouches = false
		table.register(NewNoteTableViewCell.self, forCellReuseIdentifier: String(describing: NewNoteTableViewCell.self))
		table.register(AdviceTableViewCell.self, forCellReuseIdentifier: String(describing: AdviceTableViewCell.self))
		table.register(AdviceRateTableViewCell.self, forCellReuseIdentifier: String(describing: AdviceRateTableViewCell.self))
		table.register(HelpСenterCallTableViewCell.self, forCellReuseIdentifier: String(describing: HelpСenterCallTableViewCell.self))
	}
	
	private func addNewContentBlock(for textTopics: [NoteTopic]) {
		
	}
	
	private func updateTable() {
		DispatchQueue.main.async { [weak table] in
			table?.beginUpdates()
			table?.endUpdates()
		}
	}
}

extension NewDiaryEntryViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let rawData = data[indexPath.item]
		
		if let dataModel = rawData as? Note {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewNoteTableViewCell.self), for: indexPath) as? NewNoteTableViewCell else {
				return UITableViewCell()
			}
			cell.delegate = self
			cell.configure(with: dataModel)
			return cell
			
		} else if let dataModel = rawData as? PsychologicalAdvice {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AdviceTableViewCell.self), for: indexPath) as? AdviceTableViewCell else {
				return UITableViewCell()
			}
			cell.configure(with: dataModel)
			return cell
			
		} else if let dataModel = rawData as? AdviceRate {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AdviceRateTableViewCell.self), for: indexPath) as? AdviceRateTableViewCell else {
				return UITableViewCell()
			}
			cell.delegate = self
			cell.configure(with: dataModel)
			return cell
			
		} else if rawData is helpСenterRecommendation {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HelpСenterCallTableViewCell.self), for: indexPath) as? HelpСenterCallTableViewCell else {
				return UITableViewCell()
			}
			return cell
			
		} else if let dataModel = rawData as? PositiveAdvice {
			
		} else {
			return UITableViewCell()
		}
		return UITableViewCell()
	}
}

extension NewDiaryEntryViewController: NewNoteTableViewCellDelegate {
	func addNote(with text: String, _ callback: @escaping () -> ()) {
		
		predictionModel.predict(for: text) { [weak self] textTopics in
			callback()
			guard let self = self else {
				return
			}
			if var note = self.data[0] as? Note {
				note.text = text
				note.isEditable = false
				self.data[0] = note
				self.table.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .none)
			}
			self.addNewContentBlock(for: textTopics)
			self.updateTable()
			print(textTopics)
		}
	}
	
	func textChanged() {
		updateTable()
	}
}

extension NewDiaryEntryViewController: AdviceRateTableViewCellDelegate {
	func adviceFeedback(with rate: Rate) {
		for (index, dataModel) in data.enumerated() {
			if var rateBlock = dataModel as? AdviceRate {
				rateBlock.rate = rate
				self.table.reloadRows(at: [IndexPath(item: index, section: 0)], with: .none)
			}
		}
	}
}
