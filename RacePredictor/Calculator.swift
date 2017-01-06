import Foundation

// Used to pad single-digit minute and second values with a 0
// ex: 4:4:20 -> 4:04:20
func twoDigits(number: Int) -> String {
    if (number < 10) {
        return "0\(number)"
    }
    else {
        return "\(number)"
    }
}

func kmToMiles(km: Double) -> Double {
    return km * 0.621371
}

func convertDistRunToMiles(distance_run: Double, adding_activity: Bool) -> Double {
    var distRun = distance_run
    let defaults = UserDefaults.standard
    
    if adding_activity {
        let distType = UserDefaults.standard.string(forKey: "distType")
        if distType == "km" {
            distRun = kmToMiles(km: distance_run)
        }
    }
    else {
        let distanceUnits = defaults.string(forKey: "distUnits")
        if distanceUnits == "km" {
            distRun = kmToMiles(km: distance_run)
        }
    }
    return distRun
}

func convertProjectedDistRunToMiles(projected_distance: Double) -> Double {
    var projectedDistRun = projected_distance
    let defaults = UserDefaults.standard
    let projectedDistanceUnits = defaults.string(forKey: "projectedDistUnits")
    if projectedDistanceUnits == "km" {
        projectedDistRun = kmToMiles(km: projected_distance)
    }
    return projectedDistRun
}

func predictTime(distance_run: Double, total_min_run: Double, projected_distance: Double, adding_activity: Bool) -> Array<Int> {
    
    var distRun = distance_run
    var projectedDistRun = projected_distance
    
    distRun = convertDistRunToMiles(distance_run: distRun, adding_activity: adding_activity)
    projectedDistRun = convertProjectedDistRunToMiles(projected_distance: projectedDistRun)
    
    var est_total_min = (Double)(0)
    
    if distRun != 0 {
        est_total_min = total_min_run * pow(projectedDistRun/distRun, 1.06)
    }
    
    let est_hours = (Int)(est_total_min/60)
    let est_mins = (Int)(est_total_min) - est_hours*60
    let est_secs = (Int)(est_total_min*60) - (Int)(est_total_min)*60
    
    let time:[Int] = [est_hours, est_mins, est_secs]
    
    return time
}

func calculatePace(total_min: Double, total_dist: Double) -> Array<Int> {
    let mile_pace = total_min/total_dist
    let hours = (Int)(mile_pace/60)
    let mins = (Int)(mile_pace) - hours*60
    let secs = (Int)(mile_pace*60) - (Int)(mile_pace)*60
    
    let pace:[Int] = [hours, mins, secs]
    
    return pace
}

func calculateTotalMinRun(hours_run: Double, mins_run: Double, secs_run: Double) -> Double {
    return hours_run*60 + mins_run + secs_run/60
}

// For ActivityDetailsViewController
func updateLabels(distance_run: Double, total_min_run: Double, projected_distance: Double, distance_name: String) -> String {
    let timeArray:[Int] = predictTime(distance_run: Double(distance_run), total_min_run: Double(total_min_run), projected_distance: projected_distance, adding_activity: true)
    
    var updatedLabel = "Projected " + distance_name + ": "
    if timeArray[0] != 0 {
        updatedLabel = updatedLabel + String(timeArray[0]) + ":" + twoDigits(number: timeArray[1]) + ":" + twoDigits(number: timeArray[2])
    }
    else {
        updatedLabel = updatedLabel + String(timeArray[1]) + ":" + twoDigits(number: timeArray[2])
    }
    
    return updatedLabel
}
