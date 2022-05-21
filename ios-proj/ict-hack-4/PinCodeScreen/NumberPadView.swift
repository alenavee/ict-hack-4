//
//  NumberPadView.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 21.05.2022.
//

import UIKit
import PureLayout

protocol NumberPadViewDelegate: AnyObject {
	func numberDidTap(_ number: Int)
	func clearDidTap()
	func authDidTap()
}

class NumberPadView: UIView {
	
	weak var delegate: NumberPadViewDelegate?
	
	init() {
		super.init(frame: .zero)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		let verticalStack = UIStackView()
		verticalStack.axis = .vertical
		verticalStack.spacing = 24
		verticalStack.distribution = .equalSpacing
		
		let firstLineStack = UIStackView()
		firstLineStack.axis = .horizontal
		firstLineStack.spacing = 30
		firstLineStack.distribution = .equalSpacing
		firstLineStack.addArrangedSubview(createButton(with: 1))
		firstLineStack.addArrangedSubview(createButton(with: 2))
		firstLineStack.addArrangedSubview(createButton(with: 3))
		
		let secondLineStack = UIStackView()
		secondLineStack.axis = .horizontal
		secondLineStack.spacing = 30
		secondLineStack.distribution = .equalSpacing
		secondLineStack.addArrangedSubview(createButton(with: 4))
		secondLineStack.addArrangedSubview(createButton(with: 5))
		secondLineStack.addArrangedSubview(createButton(with: 6))
		
		let thirdLineStack = UIStackView()
		thirdLineStack.axis = .horizontal
		thirdLineStack.spacing = 30
		thirdLineStack.distribution = .equalSpacing
		thirdLineStack.addArrangedSubview(createButton(with: 7))
		thirdLineStack.addArrangedSubview(createButton(with: 8))
		thirdLineStack.addArrangedSubview(createButton(with: 9))
		
		let fourthLineStack = UIStackView()
		fourthLineStack.axis = .horizontal
		fourthLineStack.spacing = 30
		fourthLineStack.distribution = .equalSpacing
		fourthLineStack.addArrangedSubview(createLocalAuthButton())
		fourthLineStack.addArrangedSubview(createButton(with: 0))
		fourthLineStack.addArrangedSubview(createEraseButton())
		
		verticalStack.addArrangedSubview(firstLineStack)
		verticalStack.addArrangedSubview(secondLineStack)
		verticalStack.addArrangedSubview(thirdLineStack)
		verticalStack.addArrangedSubview(fourthLineStack)
		
		addSubview(verticalStack)
		verticalStack.autoPinEdgesToSuperviewEdges()
	}
	
	private func createButton(with number: Int) -> UIButton {
		let button = UIButton(type: .system)
		
		button.setBackgroundColor(color: .white, forState: .normal)
		button.autoSetDimensions(to: CGSize(width: 70, height: 70))
		button.clipsToBounds = true
		button.layer.cornerRadius = 35
		button.layer.borderWidth = 3
		button.layer.borderColor = AppColors.borderPrimaryColor.cgColor
		let attrTitle = NSAttributedString(string: "\(number)", attributes: [.font : UIFont.systemFont(ofSize: 40, weight: .bold),
																			 .foregroundColor : AppColors.textPrimary])
		button.setAttributedTitle(attrTitle, for: .normal)
		button.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
		
		return button
	}
	
	private func createLocalAuthButton() -> UIButton {
		let button = UIButton(type: .system)
		
		button.backgroundColor = .clear
		button.autoSetDimensions(to: CGSize(width: 70, height: 70))
		
		let image = UIImage(named: AppImageNames.faceId)?.withRenderingMode(.alwaysTemplate)
		let imageView = UIImageView(image: image)
		imageView.tintColor = AppColors.textPrimary
		button.addSubview(imageView)
		imageView.autoSetDimensions(to: CGSize(width: 30, height: 30))
		imageView.autoCenterInSuperview()
		button.addTarget(self, action: #selector(authButtonTapped(_:)), for: .touchUpInside)
		
		return button
	}
	
	private func createEraseButton() -> UIButton {
		let button = UIButton(type: .system)
		
		button.backgroundColor = .clear
		button.autoSetDimensions(to: CGSize(width: 70, height: 70))
		let image = UIImage(named: AppImageNames.clear)?.withRenderingMode(.alwaysTemplate)
		let imageView = UIImageView(image: image)
		imageView.tintColor = AppColors.textPrimary
		button.addSubview(imageView)
		imageView.autoSetDimensions(to: CGSize(width: 30, height: 30))
		imageView.autoCenterInSuperview()
		button.addTarget(self, action: #selector(eraseButtonTapped(_:)), for: .touchUpInside)
		
		return button
	}
	
	@objc func numberButtonTapped(_ sender: UIButton) {
		guard let number = Int(sender.titleLabel?.text ?? "") else { return }
		delegate?.numberDidTap(number)
	}
	
	@objc func authButtonTapped(_ sender: UIButton) {
		delegate?.authDidTap()
	}
	
	@objc func eraseButtonTapped(_ sender: UIButton) {
		delegate?.clearDidTap()
	}
}
