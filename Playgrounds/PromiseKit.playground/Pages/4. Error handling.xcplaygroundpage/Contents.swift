//: [Previous](@previous)
/*:
 ## Error handling
 */
//: If we want to add error handling to the **Example 3**, we just need a catch block. If we want something to be executed in case of success or error we can use a finally block. Take a look on the **Example 4**:
import PromiseKit

enum MyCustomError: LocalizedError {
    case customFailure

    var errorDescription: String? {
        switch self {
        case .customFailure:
            return "Failed!"
        }
    }
}

func myAsyncFunction13() -> Promise<String> {
    return Promise { seal in
        seal.fulfill("13")
    }
}

func myAsyncFunction14() -> Promise<String> {
    return Promise { seal in
        seal.fulfill("14")
    }
}

func myAsyncFunction15() -> Promise<String> {
    return Promise { seal in
        seal.fulfill("15")
    }
}

func myAsyncFunction16() -> Promise<String> {
    return Promise { seal in
        seal.fulfill("16")
    }
}

firstly {
    myAsyncFunction13()
}.then { result -> Promise<String> in
    print(result)
    return myAsyncFunction14()
}.then { result -> Promise<String> in
    print(result)
    return myAsyncFunction15()
}.then { result -> Promise<String> in
    throw MyCustomError.customFailure
    print(result)
    return myAsyncFunction16()
}.done { result in
    print(result)
}.catch { error in
    print(error.localizedDescription)
}.finally {
    print("Finish 4")
}
//: With this structure we could stop the chain of async steps, once we got a failure, but we also could define a cleanup step to be executed independent of everything be a success or failure. Let's now take a look on how to work with an arbitrary number of promises.
//:
//: [Next](@next)
