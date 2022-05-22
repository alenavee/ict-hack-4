//
//  PredictionModel.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 21.05.2022.
//

import Foundation

class PredictionModel {
	
	private let tokenizer = BertTokenizer()
	
	lazy var module: TorchModule = {
		if let filePath = Bundle.main.path(forResource: "model-opt", ofType: "ptl"),
		   let module = TorchModule(fileAtPath: filePath) {
			return module
		} else {
			fatalError("Can't find the model file!")
		}
	}()
	
	func predict(for text: String, callback: @escaping ([NoteTopic]) -> ()) {
		DispatchQueue.global().async { [weak self] in
			guard let self = self else {
				return
			}
			var (ids, mask) = self.tokenizer.tokenizeText(text)
			let module = PredictionModel()
			let result = module.module.predict(ids: &ids, mask: &mask)
			guard let result = result else { return }
			
			var prediction = [NoteTopic]()
			prediction.append(NoteTopic(value: Float(exactly: result[0]) ?? 0, topic: .anxiety))
			prediction.append(NoteTopic(value: Float(exactly: result[1]) ?? 0, topic: .depression))
			prediction.append(NoteTopic(value: Float(exactly: result[2]) ?? 0, topic: .positive))
			prediction.append(NoteTopic(value: Float(exactly: result[3]) ?? 0, topic: .suicide))
			
			DispatchQueue.main.async {
				callback(prediction)
			}
		}
	}
}
