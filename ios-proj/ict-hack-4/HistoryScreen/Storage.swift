//
//  Storage.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 22.05.2022.
//

import Foundation

enum Content {
	case note(Note)
	case psychologicalAdvice(PsychologicalAdvice)
	case adviceRate(AdviceRate)
	case helpСenterRecommendation(HelpСenterRecommendation)
	case positiveAdvice(PositiveAdvice)
}

extension Content: Codable {
	private enum CodingKeys: String, CodingKey {
		case type = "type"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let singleContainer = try decoder.singleValueContainer()
		
		let type = try container.decode(String.self, forKey: .type)
		switch type {
		case "note":
			let note = try singleContainer.decode(Note.self)
			self = .note(note)
		case "psychologicalAdvice":
			let psychologicalAdvice = try singleContainer.decode(PsychologicalAdvice.self)
			self = .psychologicalAdvice(psychologicalAdvice)
		case "adviceRate":
			let adviceRate = try singleContainer.decode(AdviceRate.self)
			self = .adviceRate(adviceRate)
		case "helpСenterRecommendation":
			let helpСenterRecommendation = try singleContainer.decode(HelpСenterRecommendation.self)
			self = .helpСenterRecommendation(helpСenterRecommendation)
		case "positiveAdvice":
			let positiveAdvice = try singleContainer.decode(PositiveAdvice.self)
			self = .positiveAdvice(positiveAdvice)
		default:
			fatalError("Unknown type of content.")
			// or handle this case properly
		}
	}
	
	func encode(to encoder: Encoder) throws {
		var singleContainer = encoder.singleValueContainer()
		
		switch self {
		case .note(let note):
			try singleContainer.encode(note)
		case .psychologicalAdvice(let psychologicalAdvice):
			try singleContainer.encode(psychologicalAdvice)
		case .adviceRate(let adviceRate):
			try singleContainer.encode(adviceRate)
		case .helpСenterRecommendation(let helpСenterRecommendation):
			try singleContainer.encode(helpСenterRecommendation)
		case .positiveAdvice(let positiveAdvice):
			try singleContainer.encode(positiveAdvice)
		}
	}
}

struct Record : Codable{
	var date: Date
	var blocks: [Content]
}

class Storage {
	
	static let shared = Storage()
	
	var history = [Record]()
	
	init() {
		history = readData()
	}
	
	func addNewRecord(_ record: Record) {
		history.insert(record, at: 0)
		writeData(history)
	}
	
	func writeData(_ history: [Record]) {
		do {
			let fileURL = try FileManager.default
				.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
				.appendingPathComponent("diaryHistory.json")
			
			try JSONEncoder()
				.encode(history)
				.write(to: fileURL)
		} catch {
			print("error writing data")
		}
	}
	
	func readData() -> [Record] {
		do {
			let fileURL = try FileManager.default
				.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
				.appendingPathComponent("diaryHistory.json")
			
			let data = try Data(contentsOf: fileURL)
			let pastData = try JSONDecoder().decode([Record].self, from: data)
			
			return pastData
		} catch {
			print("error reading data")
			return []
		}
	}
}
