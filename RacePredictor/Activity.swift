import Foundation

class Activity: NSObject, NSCoding {
    
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
    var notes: String?
    
    init(name: String, date: String, distance: String, duration: String, pace: String, mile: String, fiveK: String, tenK: String, half: String, marathon: String, notes: String) {
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
        self.notes = notes
    }
    
    struct Keys {
        static let Name = "name"
        static let Date = "date"
        static let Distance = "distance"
        static let Duration = "duration"
        static let Pace = "pace"
        static let Mile = "mile"
        static let FiveK = "fiveK"
        static let TenK = "tenK"
        static let Half = "half"
        static let Marathon = "marathon"
        static let Notes = "notes"
    }
    
    //MARK: NSCoding
    required init(coder decoder: NSCoder) {
        if let nameObject = decoder.decodeObject(forKey: Keys.Name) as? String {
            name = nameObject
        }
        
        if let dateObject = decoder.decodeObject(forKey: Keys.Date) as? String {
            date = dateObject
        }
        
        if let distanceObject = decoder.decodeObject(forKey: Keys.Distance) as? String {
            distance = distanceObject
        }
        
        if let durationObject = decoder.decodeObject(forKey: Keys.Duration) as? String {
            duration = durationObject
        }
        
        if let paceObject = decoder.decodeObject(forKey: Keys.Pace) as? String {
            pace = paceObject
        }
        
        if let mileObject = decoder.decodeObject(forKey: Keys.Mile) as? String {
            mile = mileObject
        }
        
        if let fiveKObject = decoder.decodeObject(forKey: Keys.FiveK) as? String {
            fiveK = fiveKObject
        }
        
        if let tenKObject = decoder.decodeObject(forKey: Keys.TenK) as? String {
            tenK = tenKObject
        }
        
        if let halfObject = decoder.decodeObject(forKey: Keys.Half) as? String {
            half = halfObject
        }
        
        if let marathonObject = decoder.decodeObject(forKey: Keys.Marathon) as? String {
            marathon = marathonObject
        }
        if let notesObject = decoder.decodeObject(forKey: Keys.Notes) as? String {
            notes = notesObject
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: Keys.Name)
        coder.encode(date, forKey: Keys.Date)
        coder.encode(distance, forKey: Keys.Distance)
        coder.encode(duration, forKey: Keys.Duration)
        coder.encode(pace, forKey: Keys.Pace)
        coder.encode(mile, forKey: Keys.Mile)
        coder.encode(fiveK, forKey: Keys.FiveK)
        coder.encode(tenK, forKey: Keys.TenK)
        coder.encode(half, forKey: Keys.Half)
        coder.encode(marathon, forKey: Keys.Marathon)
        coder.encode(notes, forKey: Keys.Notes)
    }

}
