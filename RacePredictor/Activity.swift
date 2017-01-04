import UIKit

struct Activity {
    var date: String?
    var distance: String?
    var duration: String?
    
    init(date: String?, distance: String?, duration: String?) {
        self.date = date
        self.distance = distance
        self.duration = duration
    }
}
