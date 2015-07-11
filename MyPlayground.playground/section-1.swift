// Playground - noun: a place where people can play

import UIKit

//http://www.globalnerdy.com/2015/02/07/how-to-work-with-dates-and-times-in-swift-part-four-a-more-swift-like-way-to-get-the-time-interval-between-two-dates/


let userCalendar = NSCalendar.currentCalendar()

let valentinesDayComponents = NSDateComponents()
valentinesDayComponents.year = 2015
valentinesDayComponents.month = 2
valentinesDayComponents.day = 14

let valentinesDay = userCalendar.dateFromComponents(valentinesDayComponents)

let dateMakerFormatter = NSDateFormatter()
dateMakerFormatter.calendar = userCalendar
dateMakerFormatter.dateFormat = "yyyy/MM/dd"

let stPatricksDay = dateMakerFormatter.dateFromString("2015/03/17")

valentinesDay?.earlierDate(stPatricksDay!)
valentinesDay?.laterDate(stPatricksDay!)

let dayOrder = valentinesDay?.compare(stPatricksDay!)

let goHomeYoureDrunkTimeComponents = NSDateComponents()
goHomeYoureDrunkTimeComponents.year = 2015
goHomeYoureDrunkTimeComponents.month = 1
goHomeYoureDrunkTimeComponents.day = 1
goHomeYoureDrunkTimeComponents.hour = 3
goHomeYoureDrunkTimeComponents.minute = 45
goHomeYoureDrunkTimeComponents.second = 30
let goHomeYoureDrunkTime = userCalendar.dateFromComponents(goHomeYoureDrunkTimeComponents)!

// Let's create an NSDate representing Bad Poetry Day (August 18)
// at 4:20:10 p.m.
let badPoetryDayComponents = NSDateComponents()
badPoetryDayComponents.year = 2015
badPoetryDayComponents.month = 8
badPoetryDayComponents.day = 18
badPoetryDayComponents.hour = 16
badPoetryDayComponents.minute = 20
badPoetryDayComponents.second = 10
let badPoetryDay = userCalendar.dateFromComponents(badPoetryDayComponents)!


let dayHourMinuteSecond: NSCalendarUnit =
.DayCalendarUnit    |
    .HourCalendarUnit   |
    .MinuteCalendarUnit |
    .SecondCalendarUnit

let difference = NSCalendar.currentCalendar().components(
    dayHourMinuteSecond,
    fromDate: goHomeYoureDrunkTime,
    toDate: badPoetryDay,
    options: nil)
difference.day     // 229
difference.hour    // 12
difference.minute  // 34
difference.second  // 40

func -(lhs: NSDate, rhs: NSDate) -> NSDateComponents
{
    let components: NSCalendarUnit =
    .SecondCalendarUnit |
        .MinuteCalendarUnit |
        .HourCalendarUnit   |
        .DayCalendarUnit
    return NSCalendar.currentCalendar().components(components,
        fromDate: rhs,
        toDate: lhs,
        options: nil)
}

// Let's test it:
let diff = goHomeYoureDrunkTime - badPoetryDay
diff.day     // 229
diff.hour    // 12
diff.minute  // 34
diff.second  // 40

