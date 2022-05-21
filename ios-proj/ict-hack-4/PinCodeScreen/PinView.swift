//
//  PinView.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 21.05.2022.
//

import UIKit
import PureLayout

class PinView: UIView {
	
	private var dots = [UIView]()
	
	private let fillDotColor = AppColors.borderPrimaryColor
	private let emptyDotColor = AppColors.textPrimary
	
	init() {
		super.init(frame: .zero)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.spacing = 44
		stack.distribution = .equalSpacing
		
		for _ in 0...3 {
			let dot = createDot()
			dots.append(dot)
			stack.addArrangedSubview(dot)
		}

		addSubview(stack)
		stack.autoPinEdgesToSuperviewEdges()
	}
	
	private func createDot() -> UIView {
		let dotView = UIView()
		dotView.backgroundColor = emptyDotColor
		dotView.layer.cornerRadius = 12
		dotView.autoSetDimensions(to: CGSize(width: 24, height: 24))
		return dotView
	}
	
	func updatePin(_ pin: String) {
		for (index, dot) in dots.enumerated() {
			if index > pin.count - 1 {
				dot.backgroundColor = emptyDotColor
			} else {
				dot.backgroundColor = fillDotColor
			}
		}
	}
}
