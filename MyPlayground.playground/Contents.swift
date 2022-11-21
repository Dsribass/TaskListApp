import UIKit

var greeting = "Hello, playground"

let regex = try! Regex("^[a-zA-Z0-9_.-]*$")
let match = try? regex.wholeMatch(in: greeting)

print(match)
