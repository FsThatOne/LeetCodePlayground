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
//Time: O(n)    Space: O(1)
let linkList1 = LinkListGenerate([8, 9, 9])
let linkList2 = LinkListGenerate([2])
addTwoNumbers(linkList1, linkList2)

//MARK: - 3. 无重复字符的最长子串
//给定一个字符串,找出不含有重复字符的最长子串的长度.
func lengthOfLongestSubstring(_ s: String) -> Int {
    guard s.count > 0 else {
        return 0
    }
    var i = 0
    var j = i
    var maxLength = 0
    var charHash = [Character: Int]()
    while j < s.count {
        if let exist = charHash[s[j]!] {
            i = max(i, exist)
        }
        maxLength = max(maxLength, j - i + 1)
        charHash[s[j]!] = j + 1
        j += 1
    }
    return maxLength
}
//Time: O(n)    Space: O(n)
lengthOfLongestSubstring("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~")

//MARK: - 5. 最长回文子串 -TODO
//给定一个字符串 s，找到 s 中最长的回文子串。你可以假设 s 的最大长度为1000。
func longestPalindrome(_ s: String) -> String {
    func checkIfPlalindrome(_ s: String) -> Bool {
        guard s.count > 1 else {
            return true
        }
        return s == String(s.reversed())
    }
    guard s.count > 0 else {
        return ""
    }
    guard s.count > 2 else {
        return checkIfPlalindrome(s) ? s : String(s.first!)
    }
    var i = 0
    var hashMap = [Character: Int]()
    var longestPalindrome = ""
    while i < s.count {
        if let char = s[i] {
            if let index = hashMap[char] {
                if let targetString = s.subStringInRange(index...i) {
                    if checkIfPlalindrome(targetString) {
                        if longestPalindrome.count <= targetString.count {
                            longestPalindrome = targetString
                        } else {
                            hashMap[char] = i
                        }
                    }
                }
            } else {
                hashMap[char] = i
            }
            i += 1
        }
    }
    return longestPalindrome.count > 0 ? longestPalindrome : String(s.first!)
}
//Time: O(n2)   Space: O(n)
longestPalindrome("babadada")

//MARK: - 6. Z 字形变换
//将一个给定字符串根据给定的行数，以从上往下、从左到右进行 Z 字形排列。
//之后，你的输出需要从左往右逐行读取，产生出一个新的字符串. 详见https://leetcode-cn.com/problems/zigzag-conversion/
func convert(_ s: String, _ numRows: Int) -> String {
    guard numRows > 1 else {
        return s
    }
    
    var s = Array(s)
    var arr = Array(repeating: "", count: numRows)
    let num = numRows + numRows - 2
    for i in 0..<s.count {
        var index = i % num
        if index >= numRows {
            index = num - index
        }
        arr[index].append(s[i])
        
    }
    
    var result = ""
    for sub in arr {
        result += sub
    }
    
    return result
}
//Time: O(n)    Space: O(1)
convert("PAYPALISHIRING", 3)
convert("abcd", 3)

//MARK: - 24. 两两交换链表中的节点
//给定一个链表，两两交换其中相邻的节点，并返回交换后的链表。
//给定 1->2->3->4, 你应该返回 2->1->4->3.
func swapPairs(_ head: ListNode?) -> ListNode? {
    var head = head
    guard head != nil else {
        return nil
    }
    guard head?.next != nil else {
        return head
    }
    var pre = ListNode(-1)
    pre.next = head
    var a = head!
    var b = head!.next
    head = b
    while pre.next != nil, pre.next?.next != nil {
        a = pre.next!
        b = a.next
        pre.next = b
        a.next = b?.next
        b?.next = a
        pre = a
    }
    return head
}
//Time: O(n)    Space: O(1)
swapPairs(LinkListGenerate([1, 2, 3, 4]))

//MARK: - 50. Pow(x, n)
//计算x的n次幂
func myPow(_ x: Double, _ n: Int) -> Double {
    var x = x, n = n
    var result = 1.0
    if n < 0 {
        x = 1 / x
        n = -1 * n
    }
    while n != 0 {
        if n % 2 == 1 {
            result = result * x
        }
        x *= x
        n = n / 2
    }
    return result
}
//Time: O(logN)    Space: O(1)
myPow(2.0, 10)

//MARK: - 94. 二叉树的中序遍历
//递归太简单,用迭代实现:
func inorderTraversal(_ root: TreeNode?) -> [Int] {
    guard root != nil else {
        return []
    }
    var resultList = [Int]()
    var nodeStack = [TreeNode]()
    var current: TreeNode? = root
    while current != nil || !nodeStack.isEmpty {
        if current != nil {
            nodeStack.append(current!)
            current = current!.left
        } else {
            current = nodeStack.popLast()
            resultList.append(current!.val)
            current = current!.right
        }
    }
    return resultList
}
//Time: O(n)    Space: O(n)
