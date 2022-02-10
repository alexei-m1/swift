import UIKit

class Car {
    enum Errors: Error {
        case doorsOpened, windowsOpened, doorsClosed, windowsClosed, engineStarted, engineStoped, trunkOverloaded, trunkIsEmpty, trunkNotEnough
    }

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
    
    func makeAction(action: Actions) throws {
        
    }
}

class TrunkCar: Car{
    let loadCapacity: Double// Грузоподъемность
    var loaded: Double = 0.0 // Загружено в кузов кг
    
    init(brand: String, color: UIColor, trans: Car.Transmission, yearOfIssue: Int, km: Double, loadCapacity: Double) {
        self.loadCapacity = loadCapacity
        super.init(brand: brand, color: color, trans: trans, yearOfIssue: yearOfIssue, km: km)
    }
    
    override func makeAction(action: Car.Actions) throws {
        switch action {
            case .actionEngine(let state): do {
                if engine == state {
                    if  state == .on {
                        throw Errors.engineStarted
                    } else {
                        throw Errors.engineStoped
                    }
                } else {
                    engine = state
                }
            }
            
            case .actionDoor(let state): do {
                if doors == state {
                    if  state == .opened{
                        throw Errors.doorsOpened
                    } else {
                        throw Errors.doorsClosed
                    }
                } else {
                    doors = state
                }
            }
            case .actionWindow(let state): do {
                if windows == state {
                    if  state == .opened{
                        throw Errors.windowsOpened
                    } else {
                        throw Errors.windowsClosed
                    }
                } else {
                    windows = state
                }
            }
            case .loadTrunk(let kg): do {
                guard kg + self.loaded <= self.loadCapacity else {throw Errors.trunkOverloaded}
                self.loaded += kg
            }
            case .unloadTrunk(let kg): do {
                guard self.loaded != 0.0 else {
                    throw Errors.trunkIsEmpty
                }
                guard kg <= self.loaded else {
                    throw Errors.trunkNotEnough
                }
                self.loaded -= kg
            }
        }
    }
        
}

func testActions (trunkCar: TrunkCar, action: Car.Actions) throws {
    do {
        try trunkCar.makeAction(action: action)
    } catch Car.Errors.trunkNotEnough {
        print("Недостаточно загружено.")
    }catch Car.Errors.trunkIsEmpty {
        print("Кузов пуст")
    }catch Car.Errors.trunkOverloaded {
        print("Не хватает грухоподъемности")
    }catch Car.Errors.windowsClosed {
        print("Окна уже закрыты")
    }catch Car.Errors.windowsOpened {
        print("Окна уже открыты")
    }catch Car.Errors.doorsClosed {
        print("Двери уже закрыты")
    }catch Car.Errors.doorsOpened {
        print("Двери уже открыты")
    }catch Car.Errors.engineStoped {
        print("Двигатель уже остановлен")
    }catch Car.Errors.engineStarted {
        print("Двигатель уже запущен")
    }
}

var trCar = TrunkCar(brand: "Volvo", color: .blue, trans: .auto, yearOfIssue: 2019, km: 120000, loadCapacity: 40000)

try testActions(trunkCar: trCar, action: .actionWindow(.closed))

try testActions(trunkCar: trCar, action: .actionWindow(.opened))
try testActions(trunkCar: trCar, action: .actionWindow(.opened))

try testActions(trunkCar: trCar, action: .actionDoor(.closed))

try testActions(trunkCar: trCar, action: .actionDoor(.opened))
try testActions(trunkCar: trCar, action: .actionDoor(.opened))

try testActions(trunkCar: trCar, action: .actionEngine(.off))

try testActions(trunkCar: trCar, action: .actionEngine(.on))
try testActions(trunkCar: trCar, action: .actionEngine(.on))

try testActions(trunkCar: trCar, action: .unloadTrunk(10000))
print("Загружено", trCar.loaded)
try testActions(trunkCar: trCar, action: .loadTrunk(20000))
print("Загружено", trCar.loaded)
try testActions(trunkCar: trCar, action: .loadTrunk(30000))
print("Загружено", trCar.loaded)

try testActions(trunkCar: trCar, action: .unloadTrunk(10000))
print("Загружено", trCar.loaded)
try testActions(trunkCar: trCar, action: .unloadTrunk(30000))
print("Загружено", trCar.loaded)




