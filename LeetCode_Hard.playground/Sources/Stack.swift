import Foundation

public class MyStack<Value> {

    private var innerQueue = [Value]()
    
    public init() {}
    
    public func push(_ x: Value) {
        innerQueue.append(x)
    }
    
    public func pop() -> Value? {
        guard !innerQueue.isEmpty else { return nil }
        return innerQueue.removeLast()
    }
    
    public func top() -> Value? {
        return innerQueue.last
    }
    
    public func empty() -> Bool {
        return innerQueue.isEmpty
    }
}
