//
//  Date+Extensions.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import Foundation

extension Date {
    func date(byAdding components: DateComponents, in calendar: Calendar = .current) -> Date? {
        calendar.date(byAdding: components, to: self)
    }

    func date(byAdding component: Calendar.Component, value: Int, in calendar: Calendar = .current) -> Date? {
        calendar.date(byAdding: component, value: value, to: self)
    }

    func nextDate(
        matching components: DateComponents,
        matchingPolicy: Calendar.MatchingPolicy = .nextTime,
        direction: Calendar.SearchDirection = .forward,
        in calendar: Calendar = .current
    ) -> Date? {
        calendar.nextDate(
            after: self,
            matching: components,
            matchingPolicy: matchingPolicy,
            direction: direction
        )
    }

    func startOfDay(in calendar: Calendar) -> Date {
        let components = DateComponents(hour: 0, minute: 0)
        let isStartOfDay = calendar.date(self, matchesComponents: components)

        guard !isStartOfDay else {
            return self
        }

        return nextDate(
            matching: components,
            direction: .backward,
            in: calendar
        )!
    }

    var startOfDay: Date {
        startOfDay(in: .current)
    }

    func endOfDay(in calendar: Calendar = .current) -> Date {
        let components = DateComponents(hour: 23, minute: 59)
        let isEndOfDay = calendar.date(self, matchesComponents: components)

        guard !isEndOfDay else {
            return self
        }

        return nextDate(
            matching: components,
            direction: .forward,
            in: calendar
        )!
    }

    var endOfDay: Date {
        endOfDay(in: .current)
    }

    func startOfMonth(in calendar: Calendar) -> Date {
        let components = DateComponents(day: 1, hour: 0, minute: 0)
        let isStartOfMonth = calendar.date(self, matchesComponents: components)

        guard !isStartOfMonth else {
            return self
        }

        return nextDate(
            matching: components,
            direction: .backward,
            in: calendar
        )!
    }

    var startOfMonth: Date {
        startOfMonth(in: .current)
    }
}
