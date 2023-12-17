import Foundation

let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
var accountBalance = 1000
let dispatchGroup = DispatchGroup()


func withdraw(amount: Int) {
    concurrentQueue.async(group: dispatchGroup) {
        if accountBalance >= amount {
            // Thread.sleep(forTimeInterval: 1)
            accountBalance -= amount
            print("Withdrawal successful. Remaining balance: \(accountBalance)")
        } else {
            print("Insufficient funds")
        }
    }
}

func refillBalance(amount: Int) {
    concurrentQueue.async(group: dispatchGroup) {
        // Thread.sleep(forTimeInterval: 1)
        accountBalance += amount
        print("Refill successful. Remaining balance: \(accountBalance)")
    }
}

for _ in 1...5 {
    withdraw(amount: 100) // 1 2 3 4 5
    refillBalance(amount: 100) // 1 2 3 4 5
}

Thread.sleep(forTimeInterval: 3)
