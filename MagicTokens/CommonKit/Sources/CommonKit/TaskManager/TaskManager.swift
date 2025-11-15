//
//  TaskManager.swift
//  CommonKit
//
//  Created by Giordano Mattiello on 13/11/25.
//

import Foundation

public protocol TaskManagerProtocol {
    func execute(_ operation: @escaping @Sendable () async -> Void)
    func executeThrowing(_ operation: @escaping @Sendable () async throws -> Void)
    func cancel()
    var isRunning: Bool { get }
}

public final class TaskManager: TaskManagerProtocol {
    private var currentTask: Task<Void, Error>?
    
    public init() {}
    
    public func execute(_ operation: @escaping @Sendable () async -> Void) {
        cancel()
        currentTask = Task {
            await operation()
        }
    }
    
    public func executeThrowing(_ operation: @escaping @Sendable () async throws -> Void) {
        cancel()
        currentTask = Task {
            do {
                try await operation()
            } catch let error {
                throw error
            }
        }
    }
    
    public func cancel() {
        currentTask?.cancel()
        currentTask = nil
    }
    
    public var isRunning: Bool {
        guard let task = currentTask else { return false }
        return !task.isCancelled
    }
    
    deinit {
        cancel()
    }
}

