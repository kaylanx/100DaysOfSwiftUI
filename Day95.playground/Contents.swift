import Foundation

private func imperative() {
    let numbers = [1, 2, 3, 4, 5]
    var evens = [Int]()

    for number in numbers {
        if number.isMultiple(of: 2) {
            evens.append(number)
        }
    }

    print(evens)
}

private func functional() {
    let numbers = [1, 2, 3, 4, 5]
    let evens = numbers.filter { $0.isMultiple(of: 2) }

    print(evens)
}

imperative()
functional()

/// Map and CompactMap
let numbers = ["1", "2", "fish", "3"]
let evensMap = numbers.map(Int.init)
let evensCompactMap = numbers.compactMap(Int.init)

/// Result type

enum NetworkError: Error {
    case badURL
}

enum Day95Error: Error {
    case genericError
}

func createResult() -> Result<String, NetworkError> {
    return .failure(.badURL)
}

func resultWithDoCatch() {
    let result = createResult()

    do {
        let successString = try result.get()
        print(successString)
    } catch {
        print("Oops! There was an error.")
    }
}
resultWithDoCatch()

let stringResult = Result { try String(contentsOf: URL(string: "boop")!) }
print(stringResult)

let result = createResult()
let mappedError = result.mapError { error in
    Day95Error.genericError
}

print(mappedError)
