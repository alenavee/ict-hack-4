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
	
	func addNote(with text: String, _ callback: @escaping () -> ())
}

class NewNoteTableViewCell: UITableViewCell {
	
	weak var delegate: NewNoteTableViewCellDelegate?
	
	private var frameViewBottomConstraint: NSLayoutConstraint?
	
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
		button.setBackgroundColor(color: AppColors.borderPrimaryColor, forState: .disabled)
		let attrTitle = NSAttributedString(string: "Сохранить", attributes: [.font : UIFont.systemFont(ofSize: 22, weight: .semibold),
																			 .foregroundColor : AppColors.textButtonPrimary])
		button.setAttributedTitle(attrTitle, for: .normal)
		button.clipsToBounds = true
		button.layer.cornerRadius = 8
		
		return button
	}()
	
	private let activity: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(style: .large)
		view.hidesWhenStopped = true
		return view
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		textView.delegate = self
		submitButton.addTarget(self, action: #selector(submitText(_:)), for: .touchUpInside)
		
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
		frameView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 12, left: 24, bottom: 0, right: 24), excludingEdge: .bottom)
		frameViewBottomConstraint = frameView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 12)
		frameViewBottomConstraint?.autoRemove()
		
		frameView.addSubview(textView)
		textView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20))
		textView.autoSetDimension(.height, toSize: 200, relation: .greaterThanOrEqual)
		
		contentView.addSubview(submitButton)
		submitButton.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 24, bottom: 12, right: 24), excludingEdge: .top)
		submitButton.autoPinEdge(.top, to: .bottom, of: frameView, withOffset: 20)
		submitButton.autoSetDimension(.height, toSize: 70)
		
		submitButton.addSubview(activity)
		activity.autoCenterInSuperview()
	}
	
	private func buttonShowLoad() {
		submitButton.setAttributedTitle(nil, for: .normal)
		submitButton.isEnabled = false
		activity.startAnimating()
	}
	
	private func buttonHideLoad() {
		activity.stopAnimating()
		let attrTitle = NSAttributedString(string: "Сохранить", attributes: [.font : UIFont.systemFont(ofSize: 22, weight: .semibold),
																			 .foregroundColor : AppColors.textButtonPrimary])
		submitButton.setAttributedTitle(attrTitle, for: .normal)
	}
	
	@objc private func submitText(_ sender: UIButton) {
		guard let text = textView.text else { return }
		buttonShowLoad()
		delegate?.addNote(with: text) { [weak self] in
			self?.buttonHideLoad()
		}
	}
	
	func configure(with model: Note) {
		textView.text = model.text
		textView.isEditable = model.isEditable
		
		if model.isEditable {
			submitButton.isHidden = false
			submitButton.isEnabled = true
			frameViewBottomConstraint?.isActive = false
		} else {
			submitButton.isHidden = true
			submitButton.isEnabled = false
			frameViewBottomConstraint?.isActive = true
		}
	}
}

extension NewNoteTableViewCell: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		textView.resignFirstResponder()
		delegate?.textChanged()
	}
}
