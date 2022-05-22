//
//  AdviceTableViewCell.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 21.05.2022.
//

import UIKit
import PureLayout

class AdviceTableViewCell: UITableViewCell {
	
	private let title: UILabel = {
		let label = UILabel()
		label.text = "Совет:"
		label.textColor = AppColors.textPrimary
		label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
		
		return label
	}()
	
	private let adviceLabel: UITextView = {
		let textView = UITextView()
		textView.textColor = AppColors.textPrimary
		textView.font = UIFont.systemFont(ofSize: 20, weight: .regular)
		textView.isScrollEnabled = false
		textView.isEditable = false
		
		return textView
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
		frameView.backgroundColor = .white
		frameView.layer.cornerRadius = 8
		contentView.addSubview(frameView)
		frameView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24))
		
		frameView.addSubview(title)
		title.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20), excludingEdge: .bottom)
		
		frameView.addSubview(adviceLabel)
		adviceLabel.autoPinEdge(.top, to: .bottom, of: title, withOffset: 12)
		adviceLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 20, bottom: 16, right: 20), excludingEdge: .top)
	}
	
	func configure(with model: PsychologicalAdvice) {
		adviceLabel.text = model.text
		updateConstraints()
	}
}
