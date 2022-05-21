//
//  EnterPasswordViewController.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 20.05.2022.
//

import UIKit
import PureLayout
import LocalAuthentication

class EnterPasswordViewController: UIViewController {
	
	private var pin = ""
	
	private let pinView = PinView()
	
	private let router: Router
	
	init(router: Router) {
		self.router = router
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
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
		
		if pin.count == 4 {
			router.switchToMainScreen()
		}
	}
	
	func clearDidTap() {
		if pin.count > 0 {
			pin.removeLast()
			pinView.updatePin(pin)
		}
	}
	
	func authDidTap() {
		let authContext = LAContext()
		var error: NSError?
		
		if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			let reason = "Авторизуйтесь для доступа к записям"
			
			authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authError in
				if success {
					DispatchQueue.main.async {
						self?.router.switchToMainScreen()
					}
				} else {
					DispatchQueue.main.async {
						let ac = UIAlertController(title: "Не удалось выполнить вход", message: "Попробуйте ещё раз", preferredStyle: .alert)
						ac.addAction(UIAlertAction(title: "OK", style: .default))
						self?.present(ac, animated: true)
					}
				}
			}
		} else {
			let ac = UIAlertController(title: "Биометрия не доступна", message: "Используйте пароль", preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "OK", style: .default))
			self.present(ac, animated: true)
		}
	}
}
