//
//  DataModels.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 21.05.2022.
//

import Foundation

struct Note: Codable {
	var type = "note"
	var text: String
	var isEditable: Bool
}

struct PsychologicalAdvice: Codable {
	var type = "psychologicalAdvice"
	let text: String
}

enum Rate: Codable {
	case good
	case bad
	case normal
	case notRated
}

struct AdviceRate: Codable {
	var type = "adviceRate"
	var rate: Rate
}

struct HelpСenterRecommendation: Codable {
	var type = "helpСenterRecommendation"
}

struct PositiveAdvice: Codable {
	var type = "positiveAdvice"
	let text: String
	let date: Date
}

enum Topics {
	case anxiety
	case depression
	case positive
	case suicide
}

struct NoteTopic {
	let value: Float
	let topic: Topics
}
