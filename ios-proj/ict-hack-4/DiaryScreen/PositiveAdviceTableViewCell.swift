//
//  PositiveAdviceTableViewCell.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 22.05.2022.
//

import UIKit
import PureLayout

struct PositiveTexts {
	static let morning = " Удивительный факт №38: сегодня утром проснулось два солнца. Первое - космическое тело, второе - ты ❤️ Хорошего дня!"
	
	static let day = "Середина дня, Котик, бегом кушать, еда остывает! Приятного аппетита💋"
	
	static let evening = "Вкусного ужина, котик 💋"
	
	static let night = "Котя💋 Мурчательных снов тебе, выспись хорошенько 💋"
	
	static let noTime = "Котик! Мур ❤️"
}

class PositiveAdviceTableViewCell: UITableViewCell {
	
	private let positiveLabel: UILabel = {
		let label = UILabel()
		label.baselineAdjustment = .alignCenters
		label.numberOfLines = 0
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
		label.textAlignment = .center
		
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		contentView.backgroundColor = AppColors.mainBackground
		
		let frameView = UIView()
		frameView.backgroundColor = AppColors.primaryColor
		frameView.layer.cornerRadius = 8
		
		contentView.addSubview(frameView)
		frameView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24))
		
		frameView.addSubview(positiveLabel)
		positiveLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 8, left: 8, bottom: 12, right: 8))
	}
	
	func configure(with model: PositiveAdvice) {
		let time = Calendar.current.component(.hour, from: model.date)
		switch time {
		case 0...5:
			positiveLabel.text = PositiveTexts.night
		case 6...11:
			positiveLabel.text = PositiveTexts.morning
		case 12...17:
			positiveLabel.text = PositiveTexts.day
		case 18...24:
			positiveLabel.text = PositiveTexts.evening
		default:
			positiveLabel.text = PositiveTexts.noTime
		}
	}
}
