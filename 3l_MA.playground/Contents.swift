import UIKit

enum DoorWindowState: String {
    case opened = "открыты"
    case closed = "закрыты"
}

enum DoorWindowAction {
    case open, close
}

enum Transmission {
    case manual, auto
}

enum EngineState: String {
    case on = "запущен", off = "остановлен"
}


enum SportCarBrand {
    case Audi, Ferrari, Porsche
}

enum TruckCarBrand {
    case KAMAZ, Iveco, MAZ, MAN
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
    
    mutating func doorAction (action: DoorWindowAction) {
        switch action {
        case .close: self.door = .closed
        case .open: self.door = .opened
        }
    }
    
    mutating func windowAction (action: DoorWindowAction) {
        switch action {
        case .open: self.window = .opened
        case .close: self.window = .closed
        }
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

porsche.openDoor()
print(porsche.door)
porsche.doorAction(action: .close)
porsche.openWindow()
porsche.startEngine()

print(porsche.brand, porsche.model, "год выпуска:", porsche.yearOfIssue, "цвет:", porsche.color.accessibilityName, "пробег:", porsche.distance, "км")
porsche.printState(of: .window)
porsche.printState(of: .door)
porsche.printState(of: .engine)

porsche.distance += 5000
print("пробег:",porsche.distance,"км")

var audi = SportCar(color: .blue, brand: .Audi, model: "R8", yearOfIssue: 2015, trans: .manual, distance: 50000)


print(audi.brand, audi.model, "год выпуска:", audi.yearOfIssue, "цвет:", audi.color.accessibilityName, "коробка передач", audi.trans, "пробег:", audi.distance, "км")
audi.windowAction(action: .open)

audi.printState(of: .window)
audi.printState(of: .door)
audi.printState(of: .engine)


audi.distance += 15000
print("пробег:",audi.distance,"км")

struct TruckCar {
    let color: UIColor
    let brand: TruckCarBrand
    let model: String
    let yearOfIssue: Int // Год выпуска
    var door: DoorWindowState
    var window: DoorWindowState
    let trans: Transmission
    var engine: EngineState
    var distance: Int //Пробег км
    let loadCapacity: Int// Грузоподъемность
    private var loaded: Int // Загружено в кузов кг
    
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
    
    init(color: UIColor, brand: TruckCarBrand, model: String, yearOfIssue: Int, trans: Transmission, distance: Int, loadCapacity: Int) {
        self.color = color
        self.brand = brand
        self.model = model
        self.yearOfIssue = yearOfIssue
        self.trans = trans
        self.distance = distance
        self.loadCapacity = loadCapacity
        
        self.door = .closed
        self.window = .closed
        self.engine = .off
        self.loaded = 0
        
    }
    
    enum CarPart {
        case door, window, engine, trunk
    }
    
    func printState(of: CarPart){
        switch of {
        case .door: print("Двери", self.door.rawValue)
        case .window: print("Окна", self.window.rawValue)
        case .engine: print("Двигатель", self.engine.rawValue)
        case .trunk: print("Загружено", self.loaded, "кг")
        }
    }
    
    enum TruckAction {
        case Load(kilos: Int)
        case Unload(kilos: Int)
    }
    
    mutating func truckAction (action: TruckAction) {
        switch action {
        case .Load(let kilos) where kilos + self.loaded > self.loadCapacity: print("Невозможно загрузить \(kilos) кг. Уже загружено \(self.loaded) Грузоподъемность \(self.loadCapacity)")
            case .Load(let kilos): self.loaded += kilos
        case .Unload(let kilos) where kilos > self.loaded: print("Невозможно разгрузить \(kilos) кг. Загружено \(self.loaded) Грузоподъемность \(self.loadCapacity)")
        case .Unload(let kilos): self.loaded -= kilos
        }
    }
}

var kamaz = TruckCar(color: .red, brand: .KAMAZ, model: "5320", yearOfIssue: 2001, trans: .manual, distance: 500000, loadCapacity: 10000)


print(kamaz.brand, kamaz.model, "год выпуска:", kamaz.yearOfIssue, "цвет:", kamaz.color.accessibilityName, "коробка передач", kamaz.trans, "пробег:", kamaz.distance, "км", "грузоподъемность:", kamaz.loadCapacity, "кг")

kamaz.truckAction(action: .Load(kilos: 5000))
kamaz.printState(of: .trunk)
kamaz.truckAction(action: .Load(kilos: 10000))
kamaz.printState(of: .trunk)
kamaz.truckAction(action: .Unload(kilos: 10000))
kamaz.truckAction(action: .Unload(kilos: 3000))

kamaz.printState(of: .window)
kamaz.printState(of: .door)
kamaz.printState(of: .engine)
kamaz.printState(of: .trunk)


kamaz.distance += 150000
print("пробег:",kamaz.distance,"км")
