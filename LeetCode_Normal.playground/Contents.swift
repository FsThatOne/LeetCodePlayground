import Foundation
import Darwin

//MARK: - 2. 两数相加
//给定两个非空链表来表示两个非负整数.位数按照逆序方式存储,它们的每个节点只存储单个数字.将两数相加返回一个新的链表.你可以假设除了数字 0 之外,这两个数字都不会以零开头.
func addTwoNumbers(_ node1: ListNode?, _ node2: ListNode?) -> ListNode? {
    func judgeGreaterThanTen(_ node: ListNode?) -> ListNode? {
        guard node != nil else {
            return nil
        }
        if node!.val >= 10 {
            node!.val = node!.val - 10
            if node!.next != nil {
                node!.next!.val += 1
                node!.next = judgeGreaterThanTen(node!.next!)
            } else {
                let tempNode = ListNode(1)
                node!.next = tempNode
            }
        }
        return node
    }
    
    guard node1 != nil || node2 != nil else {
        return nil
    }
    if node1 == nil {
        return judgeGreaterThanTen(node2)
    } else if node2 == nil {
        return judgeGreaterThanTen(node1)
    } else {
        node1!.val += node2!.val
        node2!.val = 0
        judgeGreaterThanTen(node1)
        node1!.next = addTwoNumbers(node1!.next, node2!.next)
        return node1
    }
}
let linkList1 = LinkListGenerate([8, 9, 9])
let linkList2 = LinkListGenerate([2])
addTwoNumbers(linkList1, linkList2)
