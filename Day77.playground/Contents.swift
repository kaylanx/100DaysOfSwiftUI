import UIKit

extension BinaryInteger {
    static func * (lhs: Double, rhs: Self) -> Double {
        lhs * Double(rhs)
    }

    static func * (lhs: Self, rhs: Double) -> Double {
        Double(lhs) * rhs
    }
}

let exampleInt: Int64 = 50_000_000_000_000_001
print(exampleInt)

let result = exampleInt * 1.0
print(String(format: "%.0f", result))



@propertyWrapper
struct NonNegative<Value: BinaryInteger> {
    var value: Value

    init(wrappedValue: Value) {
        if wrappedValue < 0 {
            value = 0
        } else {
            value = wrappedValue
        }
    }

    var wrappedValue: Value {
        get { value }
        set {
            if newValue < 0 {
                value = 0
            } else {
                value = newValue
            }
        }
    }
}


var example = NonNegative(wrappedValue: 5)
example.wrappedValue -= 10
print(example.wrappedValue)

struct User {
    @NonNegative var score = 0
}

var user = User()
user.score += 10
print(user.score)

user.score -= 20
print(user.score)

