//
//  AsyncOperation.swift
//  AClassONE-Mobile
//
//  Created by Noel on 2018/8/9.
//  Copyright © 2018年 habook. All rights reserved.
//

import Foundation
import UIKit

typealias asyncBlock = (@escaping () -> Void) -> Void

internal class AsyncOperation: Operation {
    var block: asyncBlock?
    var onExecuting: Bool = false
    var onFinished: Bool = false
    override var isExecuting: Bool {
        get {
            return onExecuting
        }
    }
    override var isFinished: Bool {
        get {
            return onFinished
        }
    }
    override var isAsynchronous: Bool {
        get {
            return true
        }
    }
    class func asyncBlockOperation(withBlock block: @escaping asyncBlock) -> AsyncOperation {
        return AsyncOperation(withAsyncBlock: block)
    }
    convenience init(withAsyncBlock block: @escaping asyncBlock) {
        self.init()
        self.block = block
    }
    
    override func start() {
        if let block = self.block {
            self.willChangeValue(forKey: "isExecuting")
            onExecuting = true
            self.didChangeValue(forKey: "isExecuting")
            block {
                self.willChangeValue(forKey: "isExecuting")
                self.onExecuting = false
                self.didChangeValue(forKey: "isExecuting")
                self.willChangeValue(forKey: "isFinished")
                self.onFinished = true
                self.didChangeValue(forKey: "isFinished")
            }
        }
    }
}

