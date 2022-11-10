/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Videos : Mappable {
	var className : String?
	var videoTitle : String?
	var masteryLevel : Int?
	var isRecommended : Bool?
	var hasEndOfLessonQuiz : Bool?
	var subjectName : String?
	var isWorkedExample : Bool?
	var videoDuration : Double?
	var chapterName : String?
	var isActive : Bool?
	var topicId : Int?
	var videoId : String?
	var viewCount : Int?
	var thumbNailUrl : String?
	var topicName : String?
	var masteryStatus : String?
	var elapsedTime : Int?
	var description : String?
	var percentageCompleted : Int?
	var completionStatus : String?
	var chapterId : Int?
	var videoInteraction : [String]?
	var subjectId : Int?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		className <- map["className"]
		videoTitle <- map["videoTitle"]
		masteryLevel <- map["masteryLevel"]
		isRecommended <- map["isRecommended"]
		hasEndOfLessonQuiz <- map["hasEndOfLessonQuiz"]
		subjectName <- map["subjectName"]
		isWorkedExample <- map["isWorkedExample"]
		videoDuration <- map["videoDuration"]
		chapterName <- map["chapterName"]
		isActive <- map["isActive"]
		topicId <- map["topicId"]
		videoId <- map["videoId"]
		viewCount <- map["viewCount"]
		thumbNailUrl <- map["thumbNailUrl"]
		topicName <- map["topicName"]
		masteryStatus <- map["masteryStatus"]
		elapsedTime <- map["elapsedTime"]
		description <- map["description"]
		percentageCompleted <- map["percentageCompleted"]
		completionStatus <- map["completionStatus"]
		chapterId <- map["chapterId"]
		videoInteraction <- map["videoInteraction"]
		subjectId <- map["subjectId"]
	}

}