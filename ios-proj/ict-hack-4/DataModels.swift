//
//  DataModels.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 21.05.2022.
//

import Foundation

struct Note {
	var text: String
	var isEditable: Bool
}

struct PsychologicalAdvice {
	let text: String
}

enum Rate {
	case good
	case bad
	case normal
	case notRated
}

struct AdviceRate {
	var rate: Rate
}

struct helpСenterRecommendation {
	let centerName: String
	let centerPhone: String
}

struct PositiveAdvice {
	let text: String
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
