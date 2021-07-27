//: [Previous](@previous)
/*:
 ## Syntax
 */
//: An array of promises will be considered rejected after first error
import PromiseKit
import Foundation

let queue = DispatchQueue.global()

//: [Previous](@previous)
/*:
 ## No need to specify queue
 */
//: It will use previous used queue

queue.async(.promise) { () -> Void in
    print("1. \(Thread.current)")
}.then(on: nil) { _ -> Promise<Void> in
    print("2. \(Thread.current)")
    return .value
}.then { _ -> Promise<Void> in
    print("3. \(Thread.current)")
    return .value
}.then(on: nil) { _ -> Promise<Void> in
    print("4. \(Thread.current)")
    return .value
}

/*:
 ## Error handling
 */
//: It will use previous used queue

print("---")

enum PromiseError: LocalizedError {
    case someError
}



DispatchQueue.main.async(.promise) {
    print("1. success")
}.then { _ -> Promise<Void> in
    print("2. will fail")
    return .init(error: PromiseError.someError)
}.recover { error -> Promise<Void> in
    print("3. error: \(error)")
    return .value
}.then { _ -> Promise<String> in
    print("4. continuing after recover")
    return .value("tst")
}.get { string in
    print("get: \(string)")
}.done { result in
    print(result)
}



/*:
 ## Async after
 */
//:
after(.milliseconds(1000)).done {
    print("waited")
}


//: [Next](@next)
