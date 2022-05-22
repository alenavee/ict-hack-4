//
//  NewDiaryEntryViewController.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 21.05.2022.
//

import UIKit

class NewDiaryEntryViewController: UIViewController {
	var data: [Content] = [Content.note(Note(text: "", isEditable: true))]
	
	private let table = UITableView()
	
	private let fireworksController = FountainFireworkController()
	
	private let predictionModel = PredictionModel()
	
	private let storage = Storage.shared
	
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
		table.register(PositiveAdviceTableViewCell.self, forCellReuseIdentifier: String(describing: PositiveAdviceTableViewCell.self))
	}
	
	private func addNewContentBlock(for textTopics: [NoteTopic], text: String) {
		let maxValue = textTopics.max(by: { $0.value < $1.value })
		guard let maxValue = maxValue else {
			return
		}
		let advice = Vectorization.shared.findNearestAdvice(text)
//		let advice = AdviceTextObject(empty: 0, questionText: "", answerShort: "Хуета", id: 0)
		switch maxValue.topic {
		case .suicide:
			data.append(Content.psychologicalAdvice(PsychologicalAdvice(text: advice.answerShort)))
			data.append(Content.helpСenterRecommendation(HelpСenterRecommendation()))
		case .anxiety:
			data.append(Content.psychologicalAdvice(PsychologicalAdvice(text: advice.answerShort)))
			data.append(Content.adviceRate(AdviceRate(rate: .notRated)))
		case .depression:
			data.append(Content.psychologicalAdvice(PsychologicalAdvice(text: advice.answerShort)))
			data.append(Content.adviceRate(AdviceRate(rate: .notRated)))
		case .positive:
			makeFireworks()
			data.append(Content.positiveAdvice(PositiveAdvice(text: "", date: Date())))
		}
		table.reloadData()
		
		DispatchQueue.global().async { [weak self] in
			guard let self = self else { return }
			self.storage.addNewRecord(Record(date: Date(), blocks: self.data))
		}
	}
	
	private func updateTable() {
		DispatchQueue.main.async { [weak table] in
			table?.beginUpdates()
			table?.endUpdates()
		}
	}
	
	func reloadData() {
		table.reloadData()
	}
	
	private func makeFireworks() {
		fireworksController.addFirework(sparks: 40, above: table, sparkSize: CGSize(width: 50, height: 50), scale: 300, offsetY: -table.frame.height, animationDuration: 3)
	}
}

extension NewDiaryEntryViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let rawData = data[indexPath.item]
		
		switch rawData {
		case .note(let dataModel):
			guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewNoteTableViewCell.self), for: indexPath) as? NewNoteTableViewCell else {
				return UITableViewCell()
			}
			cell.delegate = self
			cell.configure(with: dataModel)
			return cell
		case .psychologicalAdvice(let dataModel):
			guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AdviceTableViewCell.self), for: indexPath) as? AdviceTableViewCell else {
				return UITableViewCell()
			}
			cell.configure(with: dataModel)
			return cell
		case .adviceRate(let dataModel):
			guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AdviceRateTableViewCell.self), for: indexPath) as? AdviceRateTableViewCell else {
				return UITableViewCell()
			}
			cell.delegate = self
			cell.configure(with: dataModel)
			return cell
		case .helpСenterRecommendation(_):
			guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HelpСenterCallTableViewCell.self), for: indexPath) as? HelpСenterCallTableViewCell else {
				return UITableViewCell()
			}
			return cell
		case .positiveAdvice(let dataModel):
			guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PositiveAdviceTableViewCell.self), for: indexPath) as? PositiveAdviceTableViewCell else {
				return UITableViewCell()
			}
			cell.configure(with: dataModel)
			return cell
		}
	}
}

extension NewDiaryEntryViewController: NewNoteTableViewCellDelegate {
	func addNote(with text: String, _ callback: @escaping () -> ()) {
		predictionModel.predict(for: text) { [weak self] textTopics in
			callback()
			guard let self = self else {
				return
			}
			let noteData = self.data[0]
			switch noteData {
			case .note(var note):
				note.text = text
				note.isEditable = false
				self.data[0] = Content.note(note)
				self.table.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .none)
			default: break
			}
			self.addNewContentBlock(for: textTopics, text: text)
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
			switch dataModel {
			case .adviceRate(var advice):
				advice.rate = rate
				self.data[index] = Content.adviceRate(advice)
				self.table.reloadRows(at: [IndexPath(item: index, section: 0)], with: .none)
			default: break
			}
		}
	}
}
