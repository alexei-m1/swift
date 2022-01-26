import UIKit

enum DoorWindowState: String {
    case opened = "открыты"
    case closed = "закрыты"
}
//enum DoorWindowAction {
//    case open, close
//}
enum Transmission {
    case manual, auto
}

enum EngineState: String {
    case on = "запущен", off = "остановлен"
}


enum SportCarBrand {
    case Audi, Ferrari, Porsche
}

struct SportCar {
    let color: UIColor
    let brand: SportCarBrand
    let model: String
    let yearOfIssue: Int // Год выпуска
    var door: DoorWindowState
    var window: DoorWindowState
    let trans: Transmission
    var engine: EngineState
    var distance: Int //Пробег км
    
    mutating func closeDoor () {
        self.door = .closed
    }
    
    mutating func openDoor () {
        self.door = .opened
    }
    
    mutating func openWindow () {
        self.window = .opened
    }
    
    mutating func closeWindow () {
        self.window = .closed
    }
    
    mutating func startEngine () {
        self.engine = .on
    }
    
    mutating func stopEngine () {
        self.engine = .off
    }
    
    init(color: UIColor, brand: SportCarBrand, model: String, yearOfIssue: Int, trans: Transmission, distance: Int) {
        self.color = color
        self.brand = brand
        self.model = model
        self.yearOfIssue = yearOfIssue
        self.trans = trans
        self.distance = distance
        
        self.door = .closed
        self.window = .closed
        self.engine = .off
        
    }
    
    enum CarPart {
        case door, window, engine
    }
    
    func printState(of: CarPart){
        switch of {
        case .door: print("Двери", self.door.rawValue)
        case .window: print("Окна", self.window.rawValue)
        case .engine: print("Двигатель", self.engine.rawValue)
        }
    }
}

var porsche = SportCar(color: .black, brand: .Porsche, model: "Carrera GT" , yearOfIssue: 2006, trans: .manual, distance: 20000)

//porsche.closeDoor()
porsche.openWindow()
porsche.startEngine()

print(porsche.brand, porsche.model, "год выпуска:", porsche.yearOfIssue, "цвет:", porsche.color.accessibilityName, "пробег:", porsche.distance, "км")
porsche.printState(of: .window)
porsche.printState(of: .door)
porsche.printState(of: .engine)

porsche.distance += 5000
print("пробег:",porsche.distance,"км")
