//
//  HelpСenterCallTableViewCell.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 22.05.2022.
//

import UIKit
import PureLayout

struct HelpСenterContacts {
	static let suicide = (tel: "8-800-2000-122", text: "по телефону доверия")
}

class HelpСenterCallTableViewCell: UITableViewCell {
	
	let text: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
		label.textColor = UIColor.white
		label.numberOfLines = 0
		label.baselineAdjustment = .alignCenters
		label.textAlignment = .center
		
		return label
	}()
	
	let phoneCallButton: UIButton = {
		let button = UIButton(type: .system)
		button.autoSetDimensions(to: CGSize(width: 60, height: 60))
		button.layer.cornerRadius = 30
		button.setBackgroundColor(color: .white, forState: .normal)
		button.clipsToBounds = true
		let imageView = UIImageView(image: UIImage(named: AppImageNames.phone)?.withRenderingMode(.alwaysTemplate))
		imageView.tintColor = AppColors.primaryColor
		button.addSubview(imageView)
		imageView.autoPinEdgesToSuperviewEdges()
		
		return button
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupTextLabel()
		setupView()
		phoneCallButton.addTarget(self, action: #selector(makePhoneCall(_:)), for: .touchUpInside)
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
		
		frameView.addSubview(text)
		text.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 0), excludingEdge: .right)
		
		frameView.addSubview(phoneCallButton)
		phoneCallButton.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
		phoneCallButton.autoAlignAxis(toSuperviewAxis: .horizontal)
		text.autoPinEdge(.right, to: .left, of: phoneCallButton, withOffset: 12)
	}
	
	private func setupTextLabel() {
		text.text = "Рекомендуем обратиться \(HelpСenterContacts.suicide.text): \(HelpСenterContacts.suicide.tel)"
	}
	
	@objc private func makePhoneCall(_ sender: UIButton) {
		let cleanTelephone = HelpСenterContacts.suicide.tel.filter("0123456789.".contains)
		guard let url = URL(string: "tel://\(cleanTelephone)") else {
			return
		}
		UIApplication.shared.open(url)
	}
}
