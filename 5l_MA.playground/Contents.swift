import UIKit

enum Transmission: String {
    case manual = "механика"
    case auto = "автомат"
}

 enum DoorWindowState: String {
    case opened = "открыты"
    case closed = "закрыты"
}

enum EngineState: String {
   case on = "заведен"
   case off = "заглушен"
}

enum Actions {
    case actionEngine(EngineState)
    case actionDoor(DoorWindowState)
    case actionWindow(DoorWindowState)
    case loadTrunk(Double)
    case unloadTrunk(Double)
}

protocol Car {
    var brand: String {get}
    var color: UIColor {get}
    var trans: Transmission {get}
    var yearOfIssue: Int {get} // Год выпуска
    
    var doors: DoorWindowState {get set}
    var windows: DoorWindowState {get set}
    var engine: EngineState {get set}
    var km: Double {get set}
    
    func makeAction(action: Actions)
}
extension Car {
    mutating func doorAction(action: DoorWindowState) {
        doors = action
    }
    
    mutating func windowAction(action: DoorWindowState) {
        windows = action
    }
    
    mutating func engineAction(action: EngineState) {
        engine = action
    }
}



class TrunkCar: Car{
    
    let brand: String
    let color: UIColor
    let trans: Transmission
    let yearOfIssue: Int // Год выпуска
    
    var doors: DoorWindowState = .closed
    var windows: DoorWindowState = .closed
    var engine: EngineState = .off
    var km: Double
    
    let loadCapacity: Double// Грузоподъемность
    var loaded: Double = 0.0 // Загружено в кузов кг
    
    init(brand: String, color: UIColor, trans: Transmission, yearOfIssue: Int, km: Double, loadCapacity: Double) {
        self.loadCapacity = loadCapacity
        self.brand = brand
        self.color = color
        self.trans = trans
        self.yearOfIssue = yearOfIssue
        self.km = km
    }
    
    func makeAction(action: Actions) {
        switch action {
        case .actionEngine(let state): engine = state
            case .actionDoor(let state): doors = state
            case .actionWindow(let state): windows = state
            //case .loadTrunk(let kg):
            case .loadTrunk(let kg) where kg + self.loaded > self.loadCapacity: print("Невозможно загрузить \(kg) кг. Уже загружено \(self.loaded) Грузоподъемность \(self.loadCapacity)")
            case .loadTrunk(let kg): self.loaded += kg
            case .unloadTrunk(let kg) where kg > self.loaded: print("Невозможно разгрузить \(kg) кг. Загружено \(self.loaded) Грузоподъемность \(self.loadCapacity)")
            case .unloadTrunk(let kg): self.loaded -= kg
        }
    }
}

extension TrunkCar: CustomStringConvertible{
    var description: String {
        var desc: String
        desc = brand
        desc = desc + "\nгод выпуска: " + String(yearOfIssue)
        desc = desc + "\nцвет: " + color.accessibilityName
        desc = desc + "\nкоробка передач: " + trans.rawValue
        desc = desc + "\nпробег: " + String(km) + " км"
        desc = desc + "\nгрузоподъемность: " + String(loadCapacity) + " кг"

        return desc
    }
    
}

class SportCar: Car {
    var brand: String
    var color: UIColor
    var trans: Transmission
    var yearOfIssue: Int // Год выпуска
    
    var doors: DoorWindowState = .closed
    var windows: DoorWindowState = .closed
    var engine: EngineState = .off
    var km: Double
    
    var accelerationTo100: Double //разгон до 100 км/ч в секундах
    var topSpeed: Double // максимальная скорость
    
    init(brand: String, color: UIColor, trans: Transmission, yearOfIssue: Int, km: Double, accelerationTo100: Double, topSpeed: Double) {
        self.accelerationTo100 = accelerationTo100
        self.topSpeed = topSpeed
        self.brand = brand
        self.color = color
        self.trans = trans
        self.yearOfIssue = yearOfIssue
        self.km = km
    }
    
    
    func makeAction(action: Actions) {
        switch action {
            case .actionEngine(let state): engine = state
            case .actionDoor(let state): doors = state
            case .actionWindow(let state): windows = state
            default : break
        }
    }
    
}

extension SportCar: CustomStringConvertible{
    var description: String {
        var desc: String
        desc = brand
        desc = desc + "\nгод выпуска: " + String(yearOfIssue)
        desc = desc + "\nцвет: " + color.accessibilityName
        desc = desc + "\nкоробка передач: " + trans.rawValue
        desc = desc + "\nпробег: " + String(km) + " км"
        desc = desc + "\nразгон до 100 км/ч " + String(accelerationTo100) + " секунд"
        desc = desc + "\nмаксимальная скорость: " + String(topSpeed) + " км/ч"
        

        return desc
    }
    
}

var trCar = TrunkCar(brand: "Volvo", color: .blue, trans: .auto, yearOfIssue: 2019, km: 120000, loadCapacity: 40000)

trCar.makeAction(action: .loadTrunk(20000))
trCar.makeAction(action: .loadTrunk(30000))
print("Загружено", trCar.loaded)
trCar.makeAction(action: .unloadTrunk(30000))
trCar.makeAction(action: .unloadTrunk(10000))
print("Загружено", trCar.loaded)
trCar.makeAction(action: .actionEngine(.on))
trCar.engineAction(action: .off)
print(trCar.engine)

print(trCar)

print("")

var porsche = SportCar(brand: "Porsche Carrera GT", color: .yellow, trans: .manual, yearOfIssue: 2006, km: 70000, accelerationTo100: 3.57, topSpeed: 334)

print(porsche)
porsche.windowAction(action: .opened)
porsche.engineAction(action: .on)
print("Двигатель", porsche.engine.rawValue)
print("Окна", porsche.windows.rawValue)
