//
//  TypeOfStory.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 07.03.2021.
//

import Foundation

enum TypeOfStory: String, CaseIterable {
    case comics = "comics", events = "events", series = "series", stories = "stories"
    func getIndex(num: Int)  -> TypeOfStory  {
        switch num {
        case 0:
            return TypeOfStory.comics
        case 1:
            return TypeOfStory.events
        case 2:
            return TypeOfStory.series
        case 3:
            return TypeOfStory.stories
        default:
            return TypeOfStory.comics
        }
    }
}
