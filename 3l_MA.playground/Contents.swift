import UIKit

enum DoorState {
    case open, close
}
enum Transmission {
    case manual, auto
}

enum EngineState {
    case on, off
}


enum SportCar {
    case R8, RS3, RS5
}

struct Audi {
    let color: UIColor
    let model: SportCar
    let yearOfIssue: Int // Год выпуска
    var door: DoorState
    let trans: Transmission
    var engine: EngineState
}
