//
//  NewNoteTableViewCell.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 21.05.2022.
//

import UIKit
import PureLayout

protocol NewNoteTableViewCellDelegate: AnyObject {
	func textChanged()
	
	func addNote(with text: String)
}

class NewNoteTableViewCell: UITableViewCell {
	
	weak var delegate: NewNoteTableViewCellDelegate?
	
	private let textView: UITextView = {
		let view = UITextView()
		view.font = UIFont.systemFont(ofSize: 20, weight: .regular)
		view.textColor = AppColors.textPrimary
		view.isScrollEnabled = false
		
		return view
	}()
	
	private let submitButton: UIButton = {
		let button = UIButton(type: .system)
		button.setBackgroundColor(color: AppColors.primaryColor, forState: .normal)
		let attrTitle = NSAttributedString(string: "Сохранить", attributes: [.font : UIFont.systemFont(ofSize: 22, weight: .semibold),
																			 .foregroundColor : AppColors.textButtonPrimary])
		button.setAttributedTitle(attrTitle, for: .normal)
		
		return button
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		textView.delegate = self
		
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		contentView.backgroundColor = AppColors.mainBackground
		
		let backgroundTextView = UIView()
		backgroundTextView.backgroundColor = .white
		backgroundTextView.layer.cornerRadius = 8
		
		contentView.addSubview(backgroundTextView)
		backgroundTextView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24))
		
		backgroundTextView.addSubview(textView)
		textView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20))
		textView.autoSetDimension(.height, toSize: 200, relation: .greaterThanOrEqual)
	}
}

extension NewNoteTableViewCell: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		delegate?.textChanged()
	}
}
