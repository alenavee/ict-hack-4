//
//  AdviceRateTableViewCell.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 21.05.2022.
//

import UIKit
import PureLayout

protocol AdviceRateTableViewCellDelegate: AnyObject {
	func adviceFeedback(with rate: Rate)
}

class AdviceRateTableViewCell: UITableViewCell {
	
	weak var delegate: AdviceRateTableViewCellDelegate?
	
	private let title: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
		label.textColor = UIColor.white
		label.textAlignment = .center
		label.baselineAdjustment = .alignCenters
		
		return label
	}()
	
	private let likeButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(named: AppImageNames.like)?.withRenderingMode(.alwaysTemplate), for: .normal)
		button.autoSetDimensions(to: CGSize(width: 70, height: 70))
		
		return button
	}()
	
	private let neutralButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(named: AppImageNames.neutral)?.withRenderingMode(.alwaysTemplate), for: .normal)
		button.autoSetDimensions(to: CGSize(width: 70, height: 70))
		
		return button
	}()
	
	private let dislikeButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(named: AppImageNames.dislike)?.withRenderingMode(.alwaysTemplate), for: .normal)
		button.autoSetDimensions(to: CGSize(width: 70, height: 70))
		
		return button
	}()
	
	private func setupView() {
		likeButton.addTarget(self, action: #selector(positiveFeedbackAction(_:)), for: .touchUpInside)
		neutralButton.addTarget(self, action: #selector(normalFeedbackAction(_:)), for: .touchUpInside)
		dislikeButton.addTarget(self, action: #selector(badFeedbackAction(_:)), for: .touchUpInside)
		
		let frameView = UIView()
		frameView.backgroundColor = .white
		frameView.layer.cornerRadius = 8
		contentView.addSubview(frameView)
		frameView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24))
		
		let titleView = UIView()
		titleView.backgroundColor = AppColors.borderPrimaryColor
		titleView.layer.cornerRadius = 8
		frameView.addSubview(titleView)
		titleView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
		titleView.autoSetDimension(.height, toSize: 50)
		
		titleView.addSubview(title)
		title.autoPinEdgesToSuperviewEdges(with: .zero)
		
		let stackView = UIStackView()
		stackView.spacing = 36
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		stackView.addArrangedSubview(likeButton)
		stackView.addArrangedSubview(neutralButton)
		stackView.addArrangedSubview(dislikeButton)
		frameView.addSubview(stackView)
		stackView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0), excludingEdge: .top)
	}
	
	@objc private func positiveFeedbackAction(_ sender: UIButton) {
		sender.imageView?.tintColor = AppColors.primaryColor
		delegate?.adviceFeedback(with: .good)
	}
	
	@objc private func normalFeedbackAction(_ sender: UIButton) {
		sender.imageView?.tintColor = AppColors.primaryColor
		delegate?.adviceFeedback(with: .normal)
	}
	
	@objc private func badFeedbackAction(_ sender: UIButton) {
		sender.imageView?.tintColor = AppColors.primaryColor
		delegate?.adviceFeedback(with: .bad)
	}
	
	func configure(with model: AdviceRate) {
		title.text = model.rate == .notRated ? "Вам понравился совет?" : "Спасибо за оценку!"
		likeButton.tintColor = model.rate == .good ? AppColors.borderPrimaryColor : AppColors.textSecondary
		neutralButton.tintColor = model.rate == .normal ? AppColors.borderPrimaryColor : AppColors.textSecondary
		dislikeButton.tintColor = model.rate == .bad ? AppColors.borderPrimaryColor : AppColors.textSecondary
	}
}
