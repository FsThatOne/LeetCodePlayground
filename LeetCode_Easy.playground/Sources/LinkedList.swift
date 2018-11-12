public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    func desc() -> String {
        if self.next != nil {
            return "\(self.val)->\(self.next!.desc())"
        }
        return "\(self.val)"
    }
    
    public func output() {
        print(self.desc())
    }
}

public func LinkListGenerate(_ valList: [Int]) -> ListNode? {
    guard valList.count > 0 else {
        return nil
    }
    var head: ListNode? = nil
    for val in valList.reversed() {
        let node = ListNode(val)
        node.next = head
        head = node
    }
    return head
}

public func ReverseLinkListGenerate(_ valList: [Int]) -> ListNode? {
    guard valList.count > 0 else {
        return nil
    }
    var head: ListNode? = nil
    for val in valList {
        let node = ListNode(val)
        node.next = head
        head = node
    }
    return head
}
