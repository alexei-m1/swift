import UIKit


//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.

//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)

//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.

struct Queue<Element: Comparable> {
    var items = [Element]()
    
    mutating func push ( _ item: Element){
        items.append(item)
    }
    mutating func pop () -> Element {
        return items.removeFirst()
    }
    
    
    func filter (_ elem: Element)  -> Queue<Element> {
        return Queue<Element>(items: items.filter{$0 == elem})
    }
    
    func sorted (by: (Element, Element) -> Bool)  -> Queue<Element> {
        return Queue<Element>(items: items.sorted(by: by))
    }
        
    subscript (i: Int) -> Element? {
        return i < items.count ? items[i] : nil
    }
}

var str = Queue<String>()

str.push("123")
str.push("355")
str.push("324432")
str.push("789")
print(str.filter("123"))

print(str.sorted(by: {$0 < $1}))

print(str)
str.pop()
print(str)
str.pop()
print(str)

print(str[2] ?? "Нет такого элемента")

