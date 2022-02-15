//
//  ViewController.swift
//  Tasks
//
//  Created by Dineshkumar Kandasamy on 09/02/22.
//

import UIKit

class TaskViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /// Method where we can use async for asynchronus integration
    
    private func getUserInfo() {
        
        Task.init {
            
            do {
                let users = try await getUserNameDetails()
                print("Fetched \(users.count) users.")
            } catch {
                print("Fetching users failed with error \(error)")
            }
            
        }
        
    }
    
    /// Method where we can use async for asynchronus integration
    
    private func getUserInfoWithAsync() async {
        
        do {
            let users = try await getUserNameDetails()
            print("Fetched \(users.count) users.")
        } catch {
            print("Fetching users failed with error \(error)")
        }
        
    }
    
    
}

//MARK: - Single Task Requests
/// Get multiple user details using single Task
extension TaskViewController {
    
    /// Managing single Task with mutiple fetch requests
    
    private func getAllUsersInformation() {
        
        Task.init {
            
            do {
                let names = try await getUserNameDetails()
                let phones = try await getUserPhoneDetails()
                let cities = try await getUserCityDetails()
                let pincodes = try await getUserPinCodeDetails()
                
                print("Fetched \(names.count) users.")
                print("Fetched \(phones.count) users.")
                print("Fetched \(cities.count) users.")
                print("Fetched \(pincodes.count) users.")
                
            } catch {
                print("Fetching users failed with error \(error)")
            }
            
        }
        
    }
    
}

//MARK: - Multiple Task Requests
/// Get multiple user details using single Task
extension TaskViewController {
    
    /// Managing single Task with mutiple fetch requests
    
    private func getAllUsersInfo() async {
        
        let userNameTask = Task { () -> [String] in
            return try await getUserNameDetails()
        }
        
        let phoneTask = Task { () -> [Int] in
            return try await getUserPhoneDetails()
        }
        
        let citiesTask = Task { () -> [String] in
            return try await getUserCityDetails()
        }
        
        let pincodeTask = Task { () -> [Int] in
            return try await getUserPinCodeDetails()
        }
        
        do {
            let names = try await userNameTask.value
            let phones = try await phoneTask.value
            let cities = try await citiesTask.value
            let pincodes = try await pincodeTask.value
            
            print("Fetched \(names.count) names.")
            print("Fetched \(phones.count) phones.")
            print("Fetched \(cities.count) cities.")
            print("Fetched \(pincodes.count) pincodes.")
            
        } catch {
            print("Fetching users failed with error \(error)")
        }
        
    }
    
}

/// Fetch Requests
/// Get multiple user details
extension TaskViewController {
    
    private func getUserNameDetails() async throws -> [String] {
        return ["Steven", "Mark", "Alex", "Max"]
    }
    
    private func getUserPhoneDetails() async throws -> [Int] {
        return [9892993890, 8129483938, 3242532345]
    }
    
    private func getUserCityDetails() async throws -> [String] {
        return ["Boston", "Chennai", "Madurai", "Coimbatore"]
    }
    
    private func getUserPinCodeDetails() async throws -> [Int] {
        return [637002, 637004, 637010]
    }
    
}

//MARK: - Multiple Task Requests
/// Get multiple user details using single Task
///
extension TaskViewController {
    
    func printGeneralMessage() async {
        /// Group task with out handling error
        let string = await withTaskGroup(of: String.self) { group -> String in
            group.addTask { "Its" }
            group.addTask { "a" }
            group.addTask { "Example" }
            group.addTask { "of" }
            group.addTask { "Group" }
            group.addTask { "Task" }
            
            var collected = [String]()
            
            for await value in group {
                collected.append(value)
            }
            
            return collected.joined(separator: " ")
        }
        
        print(string)
    }
    
}
