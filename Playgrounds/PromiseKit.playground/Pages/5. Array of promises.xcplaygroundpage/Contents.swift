//: [Previous](@previous)
/*:
 ## Array of promises
 */
//: Let's start with some functions that returns promises. Consider we want to run all these promises simultaneously and continue when they are fulfilled. Take a look on the **Example 5**:
import PromiseKit

func myAsyncFunction17() -> Promise<String> {
    return Promise { seal in
        seal.fulfill("17")
    }
}

func myAsyncFunction18() -> Promise<String> {
    return Promise { seal in
        seal.fulfill("18")
    }
}

func myAsyncFunction19() -> Promise<String> {
    return Promise { seal in
        seal.fulfill("19")
    }
}

func myAsyncFunction20() -> Promise<String> {
    return Promise { seal in
        seal.fulfill("20")
    }
}

let promises = [myAsyncFunction17(), myAsyncFunction18(), myAsyncFunction19(), myAsyncFunction20()]

when(fulfilled: promises)
    .done { results in
        results.forEach { print($0) }
        print("Finish 5")
    }
//: This structure creates a clean way to handle an array of async steps that could be running simultaneously in any order, and we needed all of them before continue the code execution. We have a lot of benefits like not having to deal with DispatchGroups and also benefiting from the already known **catch** and **finally blocks**
