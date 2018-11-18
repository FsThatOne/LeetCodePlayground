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
lengthOfLongestSubstring("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~")

//MARK: - 5. 最长回文子串
//给定一个字符串 s，找到 s 中最长的回文子串。你可以假设 s 的最大长度为1000。
func longestPalindrome(_ s: String) -> String {
    func checkIfPlalindrome(_ s: String) -> Bool {
        guard s.count > 1 else {
            return true
        }
        if s.first == s.last {
            return checkIfPlalindrome(String(s.dropFirst().dropLast()))
        } else {
            return false
        }
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
                if let targetString = s.substingInRange(index...i) {
                    if checkIfPlalindrome(targetString) {
                        longestPalindrome = longestPalindrome.count > targetString.count ? longestPalindrome : targetString
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
longestPalindrome("babadada")
