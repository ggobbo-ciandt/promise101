//: [Previous](@previous)
/*:
 ## How to use PromiseKit?
 */
//: Instead of passing a completion closure as parameter, we should return a Promise. Take a look on the **Example 3**:
import PromiseKit

func myAsyncFunction9() -> Promise<String> {
    return Promise { seal in
        seal.fulfill("9")
    }
}

func myAsyncFunction10() -> Promise<String> {
    return Promise { seal in
        seal.fulfill("10")
    }
}

func myAsyncFunction11() -> Promise<String> {
    return Promise { seal in
        seal.fulfill("11")
    }
}

func myAsyncFunction12() -> Promise<String> {
    return Promise { seal in
        seal.fulfill("12")
    }
}

firstly {
    myAsyncFunction9()
}.then { result -> Promise<String> in
    print(result)
    return myAsyncFunction10()
}.then { result -> Promise<String> in
    print(result)
    return myAsyncFunction11()
}.then { result -> Promise<String> in
    print(result)
    return myAsyncFunction12()
}.done { result in
    print(result)
    print("Finish 3")
}
//: By doing that, we could chain multiples steps and avoid the deep nested callbacks structure from the **Example 1**. Let's try now some error handling.
//:
//: [Next](@next)
