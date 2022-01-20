import UIKit
//1. Написать функцию, которая определяет, четное число или нет.
func isEven (_ n: Int) -> Bool{
    return n % 2 == 0
}

print(isEven(10))

//2. Написать функцию, которая определяет, делится ли число без остатка на 3.

func isDividedIntoThree(_ n: Int) -> Bool {
    return n % 3 == 0
}

print(isDividedIntoThree(9))

//3. Создать возрастающий массив из 100 чисел.

var array : [Int] = []
for i in 1...100 {
    array.append(i)
}
print(array)

//Второй вариант
var array1 = Array(1...100)
print(array1)


//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
var index = 0
while array.count > index {
    if isEven(array[index]) {
        array.remove(at: index)
    } else if !isDividedIntoThree(array[index]) {
        array.remove(at: index)
    } else {
        index += 1
    }
}

print(array)

//Второй вариант решения
for value in array1 {
    if isEven(value) {
        array1.remove(at: array1.firstIndex(of: value)!)
    } else if !isDividedIntoThree(value) {
        array1.remove(at: array1.firstIndex(of: value)!)
    }
}
print(array1)

//Третий вариант
var array3 = Array(1...100).filter{ $0 % 2 != 0}.filter{ $0 % 3 == 0 }

print(array3)

//5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.

var fibArray: [Int] = [0, 1]

func addFibonacci (_ arr: inout [Int]) {
    arr.append(arr[arr.count - 1] + arr[arr.count - 2])
}
for _ in 1...50 {
    addFibonacci(&fibArray)
}

print(fibArray)

//6. * Заполнить массив из 100 элементов различными простыми числами.
//a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
//b. Пусть переменная p изначально равна двум — первому простому числу.
//c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p..
//d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
//e. Повторять шаги c и d, пока возможно.


var p: Int
var n: Int = 100 //
var primeArray = Array(2...n)


p = primeArray[0]
while p < primeArray.last! {
    for i in stride(from: p + p, through: n + 1, by: p) {
        if let x = primeArray.firstIndex(of: i) {
            primeArray.remove(at: x)
        }
    }
    p = primeArray[primeArray.firstIndex(of: p)! + 1]
}

print(primeArray)
