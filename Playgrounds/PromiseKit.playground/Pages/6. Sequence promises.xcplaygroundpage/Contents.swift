//: [Previous](@previous)
/*:
 ## Sequence promises
 */
//: Take a look on the **Example 6**. We want to execute theses functions in sequence, so we need to add a clousures with promises to array and send to resolveSequentially.
import PromiseKit

extension Promise {
    static func resolveSequentially(promiseFns: [() -> Promise<T>]) -> Promise<T>? {
        return promiseFns.reduce(nil) { fn1, fn2 in
            return fn1?.then { _ in
                return fn2()
                } ?? fn2()
        }
    }
}

func func1() -> Promise<Void> {
    return Promise { seal in
        DispatchQueue.main.asyncAfter(deadline: .now()+9) {
            print("func1")
            seal.fulfill(())
        }
    }
}

func func2() -> Promise<Void> {
    return Promise { seal in
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            print("func2")
            seal.fulfill(())
        }
    }
}

func func3() -> Promise<Void> {
    return Promise { seal in
        DispatchQueue.main.asyncAfter(deadline: .now()+7) {
            print("func3")
            seal.fulfill(())
        }
    }
}

func func4() -> Promise<Void> {
    return Promise { seal in
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            print("func4")
            seal.fulfill(())
        }
    }
}

// Not working, because functions perform on add array
print("simultaneous promises")
let arrayOfPromises = [func1(), func2(), func3(), func4()]
let promiseFns1 = arrayOfPromises.map({ (promise: Promise<Void>) -> (()-> Promise<Void>) in
    return { return promise }
})
Promise.resolveSequentially(promiseFns: promiseFns1)


// Working, because add clousure/promises
DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
    print("sequence promises")
    let promiseFns2 = [func1, func2, func3, func4]
    Promise.resolveSequentially(promiseFns: promiseFns2)
}

//: [Next](@next)
