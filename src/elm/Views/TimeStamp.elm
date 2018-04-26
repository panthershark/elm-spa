module Views.TimeStamp exposing (format, toDateString)

import Date exposing (Date)
import Date.Extra as Date


toDateString : Date -> String
toDateString dt =
    Date.toFormattedString "M/dd/yyyy" dt


format : Date -> Date -> String
format dtNow dt =
    let
        seconds_ago =
            Date.diff Date.Second dt dtNow

        minutes_ago =
            Date.diff Date.Minute dt dtNow

        hours_ago =
            Date.diff Date.Hour dt dtNow

        days_ago =
            Date.diff Date.Day dt dtNow
    in
    if minutes_ago < 5 then
        toString seconds_ago ++ " seconds ago"
    else if hours_ago == 0 then
        toString minutes_ago ++ " minutes ago"
    else if hours_ago == 1 then
        "an hour ago"
    else if days_ago == 0 then
        toString hours_ago ++ " hours ago"
    else if days_ago == 1 then
        "a day ago"
    else if days_ago < 5 then
        toString days_ago ++ " days ago"
    else
        toDateString dt
