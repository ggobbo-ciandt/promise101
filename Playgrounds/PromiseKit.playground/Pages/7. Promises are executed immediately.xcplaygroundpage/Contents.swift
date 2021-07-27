//: [Previous](@previous)
/*:
 ## Promises are executed immediately
 */
//: An important thing to consider when developing is that promises are executed as soon as the got instantiated
import PromiseKit

enum PromiseError: LocalizedError {
    case unknown
    case noPromises
}

func myAsyncFunction21() -> Promise<String> {
//    return .init(error: PromiseError.unknown)
    print("21")
    return .value("21")
}

func myAsyncFunction22() -> Promise<String> {
    print("22")
    return .value("22")
}

func myAsyncFunction23() -> Promise<String> {
    print("23")
    return .value("23")
}

func myAsyncFunction24() -> Promise<String> {
    print("24")
    return .value("24")
}

let promises = [myAsyncFunction21(), myAsyncFunction22(), myAsyncFunction23(), myAsyncFunction24()]

when(fulfilled: promises)
    .done { results in
        print("Done 7 unwrapped: \(results)")
    }.catch { error in
        print("Failed 7 unwrapped: \(error)")
    }

/*:
 ## Wrap in a closure to avoid that
 */


let wrappedPromises = [{ myAsyncFunction21() },
                       { myAsyncFunction22() },
                       { myAsyncFunction23() },
                       { myAsyncFunction24() }]


func executeSequentially(_ wrappedPromises: [() -> Promise<String>] ) -> Promise<Void> {
    return wrappedPromises.reduce(Promise<Void>.value) { p1, p2 in
        return p1.asVoid().then { _ in
            return p2().asVoid()
        }
    }
}

executeSequentially(wrappedPromises)
    .done { _ in
        print("Done 7 wrapped")
    }.catch { error in
        print("Failed 7 wrapped")
    }

//: [Next](@next)
