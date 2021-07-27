//: [Previous](@previous)
/*:
 ## When(fulfilled:) rejects after first error
 */
//: An array of promises will be considered rejected after first error
import PromiseKit
import Foundation

enum PromiseError: LocalizedError {
    case unknown
    case noPromises
}

func myAsyncFunction25() -> Promise<String> {
    DispatchQueue.global().async(.promise) { () -> Promise<String> in
         return .init(error: PromiseError.unknown)
        print("25")
        return Promise<String>.value("25")
    }.then(on: .global()) {
        $0
    }
}

func myAsyncFunction26() -> Promise<String> {
    DispatchQueue.global().async(.promise) { () -> Promise<String> in
        print("26")
        sleep(1)
        return Promise<String>.value("26")
    }.then(on: .global()) {
        $0
    }
}

func myAsyncFunction27() -> Promise<String> {
    DispatchQueue.global().async(.promise) { () -> Promise<String> in
        print("27")
        sleep(2)
        return Promise<String>.value("27")
    }.then(on: .global()) {
        $0
    }
}

func myAsyncFunction28() -> Promise<String> {
    DispatchQueue.global().async(.promise) { () -> Promise<String> in
        print("28")
        sleep(3)
        return Promise<String>.value("28")
    }.then(on: .global()) {
        $0
    }
}

var start = Date()

when(fulfilled: [myAsyncFunction25(), myAsyncFunction26(), myAsyncFunction27(), myAsyncFunction28()])
    .done { results in
        print("Done 7 fulfilled: \(results)")
    }.catch { error in
        print("Failed 7 fulfilled")
    }.finally {
        print("Finally 7 fulfilled. Elapsed: \(Date().timeIntervalSince(start))")
    }



//: [Previous](@previous)
/*:
 ## When(resolved:) waits all promises results
 */

print("---")

start = Date()

when(resolved: [myAsyncFunction25(), myAsyncFunction26(), myAsyncFunction27(), myAsyncFunction28()])
    .done { results in
        var successes = ""
        var errors = ""
        results.map {
            switch $0 {
            case .fulfilled(let success):
                successes += " \(success)"
            case .rejected(let error):
                errors += " \(error)"
            }
        }
        print("Done 7 resolved. Successes:\(successes), Errors:\(errors)")
    }.catch { error in
        print("Failed 7 resolved")
    }.finally {
        print("Finally 7. resolved: \(Date().timeIntervalSince(start))")
    }
//: [Next](@next)
