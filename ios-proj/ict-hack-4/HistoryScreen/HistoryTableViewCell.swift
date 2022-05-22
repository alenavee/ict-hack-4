//
//  HistoryTableViewCell.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 22.05.2022.
//

import UIKit
import PureLayout

class HistoryTableViewCell: UITableViewCell {
	
	private let dateFormatter: DateFormatter = {
		let dateFormatterDate = DateFormatter()
		dateFormatterDate.dateFormat = "dd/MM/yyyy"
		
		return dateFormatterDate
	}()
	
	private let timeFormatter: DateFormatter = {
		let dateFormatterDate = DateFormatter()
		dateFormatterDate.dateFormat = "HH:mm"
		
		return dateFormatterDate
	}()
	
	private let dateLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
		label.textColor = AppColors.textPrimary
		label.numberOfLines = 0
		
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupLayout() {
		contentView.backgroundColor = AppColors.mainBackground
		
		let frameView = UIView()
		frameView.backgroundColor = .white
		frameView.layer.cornerRadius = 8
		
		contentView.addSubview(frameView)
		frameView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24))
		
		frameView.addSubview(dateLabel)
		dateLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 8, left: 12, bottom: 12, right: 8))
	}
	
	func configure(_ date: Date) {
		dateLabel.text = "Запись от \(dateFormatter.string(from: date)) \(timeFormatter.string(from: date))"
	}
}
