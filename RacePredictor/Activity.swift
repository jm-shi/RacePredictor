import UIKit

struct Activity {
    var name: String?
    var date: String?
    var distance: String?
    var duration: String?
    var pace: String?
    var mile: String?
    var fiveK: String?
    var tenK: String?
    var half: String?
    var marathon: String?
    
    init(name: String?, date: String?, distance: String?, duration: String?, pace: String?, mile: String?, fiveK: String?, tenK: String?, half: String?, marathon: String?) {
        self.name = name
        self.date = date
        self.distance = distance
        self.duration = duration
        self.pace = pace
        self.mile = mile
        self.fiveK = fiveK
        self.tenK = tenK
        self.half = half
        self.marathon = marathon
    }
}
