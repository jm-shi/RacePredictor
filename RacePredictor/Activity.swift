import UIKit

struct Activity {
    var date: String?
    var distance: String?
    var time: String?
    
    init(date: String?, distance: String?, time: String?) {
        self.date = date
        self.distance = distance
        self.time = time
    }
}
