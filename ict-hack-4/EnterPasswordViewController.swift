//
//  EnterPasswordViewController.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 20.05.2022.
//

import UIKit
import PureLayout

class EnterPasswordViewController: UIViewController {
	
	private var pin = ""
	
	private let pinView = PinView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
	}
	
	private func setupViews() {
		view.backgroundColor = AppColors.mainBackground
		
		let numberPad = NumberPadView()
		numberPad.delegate = self
		view.addSubview(numberPad)
		numberPad.autoSetDimensions(to: CGSize(width: 270, height: 360))
		numberPad.autoPinEdge(toSuperviewEdge: .bottom, withInset: 100)
		numberPad.autoAlignAxis(toSuperviewAxis: .vertical)
		
		view.addSubview(pinView)
		pinView.autoAlignAxis(toSuperviewAxis: .vertical)
		pinView.autoPinEdge(.bottom, to: .top, of: numberPad, withOffset: -56)
	}
}

extension EnterPasswordViewController: NumberPadViewDelegate {
	func numberDidTap(_ number: Int) {
		if pin.count < 4 {
			pin += "\(number)"
			pinView.updatePin(pin)
		}
	}
	
	func clearDidTap() {
		if pin.count > 0 {
			pin.removeLast()
			pinView.updatePin(pin)
		}
	}
	
	func authDidTap() {
		
	}
}
