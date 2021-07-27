//: [Previous](@previous)
/*:
 ## Issues with async code
 */
//: Take a look on the **Example 1**. We want to execute some steps, one after another considering they can be asynchronous:
func myAsyncFunction1(completion: (String) -> Void) {
    completion("1")
}

func myAsyncFunction2(completion: (String) -> Void) {
    completion("2")
}

func myAsyncFunction3(completion: (String) -> Void) {
    completion("3")
}

func myAsyncFunction4(completion: (String) -> Void) {
    completion("4")
}


myAsyncFunction1 { result in
    print(result)
    myAsyncFunction2 { result in
        print(result)
        myAsyncFunction3 { result in
            print(result)
            myAsyncFunction4 { result in
                print(result)
                print("Finish 1")
            }
        }
    }
}
//: The above solution would be the most common way to solve that, adding a callback inside a callback for each step, producing a deep horizontal and ugly code. What if we want these steps to be executed simultaneously? What if we want to execute an arbitrary number of steps in sequence? Take a look on the **Example 2**:
import Foundation
let dispatchGroup = DispatchGroup()

func myAsyncFunction5() -> String {
    dispatchGroup.leave()
    return "5"
}

func myAsyncFunction6() -> String {
    dispatchGroup.leave()
    return "6"
}

func myAsyncFunction7() -> String {
    dispatchGroup.leave()
    return "7"
}

func myAsyncFunction8() -> String {
    dispatchGroup.leave()
    return "8"
}

let steps = [myAsyncFunction5, myAsyncFunction6, myAsyncFunction7, myAsyncFunction8]

(0..<steps.count)
    .forEach { _ in dispatchGroup.enter() }

dispatchGroup.notify(queue: .main) {
    print("Finish 2")
}

steps.forEach { step in
    let result = step()
    print(result)
}
//: By using DispatchGroups we are able to handle an arbitrary number of async steps that could run simultaneously and in any order. But this adds extra complexity to every step. Consider that we may have an alternative path to handle errors that can happen on any step and this can start to be a nightmare. Hopefully the promises pattern can help us with that. Let's take a look on how that works.
//:
//: **Obs.: Please make sure you build the project before testings the code with promises, or the Playground may not work properly**
//:
//:[Next](@next)
