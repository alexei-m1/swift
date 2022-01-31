import UIKit

class Car {
    enum Actions {
        case actionEngine(EngineState)
        case actionDoor(DoorWindowState)
        case actionWindow(DoorWindowState)
        case loadTrunk(Double)
        case unloadTrunk(Double)
    }
    
     enum DoorWindowState: String {
        case opened = "открыты"
        case closed = "закрыты"
    }
    
    enum Transmission: String {
        case manual = "механика"
        case auto = "автомат"
    }
    
     enum EngineState: String {
        case on = "заведен"
        case off = "заглушен"
    }
    
    let brand: String
    let color: UIColor
    let trans: Transmission
    let yearOfIssue: Int // Год выпуска
    
    var doors: DoorWindowState = .closed
    var windows: DoorWindowState = .closed
    var engine: EngineState = .off
    var km: Double

    
    init(brand: String, color: UIColor, trans: Transmission, yearOfIssue: Int, km: Double) {
        self.brand = brand
        self.color = color
        self.trans = trans
        self.yearOfIssue = yearOfIssue
        self.km = km
    }
    
    func makeAction(action: Actions) {
    }
}

class TrunkCar: Car{
    let loadCapacity: Double// Грузоподъемность
    var loaded: Double = 0.0 // Загружено в кузов кг
    
    init(brand: String, color: UIColor, trans: Car.Transmission, yearOfIssue: Int, km: Double, loadCapacity: Double) {
        self.loadCapacity = loadCapacity
        super.init(brand: brand, color: color, trans: trans, yearOfIssue: yearOfIssue, km: km)
    }
    
    override func makeAction(action: Car.Actions) {
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

var trCar = TrunkCar(brand: "Volvo", color: .blue, trans: .auto, yearOfIssue: 2019, km: 120000, loadCapacity: 40000)

trCar.makeAction(action: .loadTrunk(20000))
trCar.makeAction(action: .loadTrunk(30000))
print("Загружено", trCar.loaded)
trCar.makeAction(action: .unloadTrunk(30000))
trCar.makeAction(action: .unloadTrunk(10000))
print("Загружено", trCar.loaded)
trCar.makeAction(action: .actionEngine(.on))
print(trCar.engine)

print(trCar.brand, "год выпуска:", trCar.yearOfIssue, "цвет:", trCar.color.accessibilityName, "коробка передач:", trCar.trans.rawValue, "пробег:", trCar.km, "км", "грузоподъемность:", trCar.loadCapacity, "кг")

class SportCar: Car {
    var accelerationTo100: Double //разгон до 100 км/ч в секундах
    var topSpeed: Double // максимальная скорость
    
    init(brand: String, color: UIColor, trans: Car.Transmission, yearOfIssue: Int, km: Double, accelerationTo100: Double, topSpeed: Double) {
        self.accelerationTo100 = accelerationTo100
        self.topSpeed = topSpeed
        super.init(brand: brand, color: color, trans: trans, yearOfIssue: yearOfIssue, km: km)
    }
    
    override func makeAction(action: Car.Actions) {
        switch action {
            case .actionEngine(let state): engine = state
            case .actionDoor(let state): doors = state
            case .actionWindow(let state): windows = state
            default : break
        }
    }
    
}


var porsche = SportCar(brand: "Porsche Carrera GT", color: .yellow, trans: .manual, yearOfIssue: 2006, km: 70000, accelerationTo100: 3.57, topSpeed: 334)

print(porsche.brand, "год выпуска:", porsche.yearOfIssue, "цвет:", porsche.color.accessibilityName, "коробка передач:", porsche.trans.rawValue, "пробег:", porsche.km, "км", "разгон до 100 км/ч", porsche.accelerationTo100, "секунд")
porsche.makeAction(action: .actionEngine(.on))
porsche.makeAction(action: .actionWindow(.opened))
print("Двигатель", porsche.engine.rawValue)
print("Окна", porsche.windows.rawValue)
