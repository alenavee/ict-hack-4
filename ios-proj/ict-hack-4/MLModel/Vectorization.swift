//
//  Vectorization.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 22.05.2022.
//

import Foundation
import NaturalLanguage

struct AdviceTextObject: Codable {
	let empty: Int
	let questionText, answerShort: String
	let id: Int
	var vector: [Double]?
	
	enum CodingKeys: String, CodingKey {
		case empty = ""
		case questionText, answerShort, id
	}
}

class Vectorization {
	
	static var shared = Vectorization()
	
	private let tokenizer = BertTokenizer()
	
	var adviseTexts = [AdviceTextObject]()
	
	init() {
		adviseTexts = readData()
	}
	
	func findNearestAdvice(_ text: String) -> AdviceTextObject {
		var diff: Double = 0
		var adviceAns = adviseTexts.first!
		let textVector = tokenizer.pseudoTokenizeText(text)
		for adviceObject in adviseTexts {
			let similarity = cosineSimilarity(a: textVector, b: adviceObject.vector!)
			if similarity > diff {
				diff = similarity
				adviceAns = adviceObject
			}
		}
		
		return adviceAns
	}
	
	private func cosineSimilarity(a: [Double], b: [Double]) -> Double {
		return dot(a, b) / (mag(a) * mag(b))
	}
	
	private func readData() -> [AdviceTextObject] {
		do {
			guard let filePath = Bundle.main.path(forResource: "advices-data", ofType: "json") else {
				return []
			}
			let fileURL = URL(fileURLWithPath: filePath)
			
			let data = try Data(contentsOf: fileURL)
			var pastData = try JSONDecoder().decode([AdviceTextObject].self, from: data)
			for (index, var advice) in pastData.enumerated() {
				advice.vector = tokenizer.pseudoTokenizeText(advice.questionText)
				pastData[index] = advice
			}
			return pastData
		} catch {
			print(error)
			return []
		}
	}
	
	private func dot(_ a: [Double], _ b: [Double]) -> Double {
		assert(a.count == b.count, "Vectors must have the same dimension")
		let result = zip(a, b)
			.map { $0 * $1 }
			.reduce(0, +)

		return result
	}

	private func mag(_ vector: [Double]) -> Double {
		return sqrt(dot(vector, vector))
	}
}

