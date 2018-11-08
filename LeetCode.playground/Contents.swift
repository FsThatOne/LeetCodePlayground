//PCH
import Foundation
import Darwin

//MARK: - 1. 两数之和
//给定一个整数数组和一个目标值,找出数组中和为目标值的两个数.你可以假设每个输入只对应一种答案,且同样的元素不能被重复利用.
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    for i in 0..<nums.count {
        for j in 0..<nums.count {
            if j == i {
                continue
            }
            if nums[i] + nums[j] == target {
                return [i, j]
            }
        }
    }
    return []
}
twoSum([3,2,4], 6)

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
    return 0
}

//MARK: - 7. 反转整数
//给定一个 32 位有符号整数,将整数中的数字进行反转.
func reverse(_ x: Int) -> Int {
    let belowZero: Int = x > 0 ? 1 : -1
    var absNum: Int = x*belowZero
    var finalNum = 0
    while absNum > 0 {
        let key = absNum % 10
        finalNum = finalNum * 10 + key
        absNum/=10
    }
    let rangeLimit = Int(-powf(2, 31))...Int(powf(2, 31)-1)
    return rangeLimit.contains(finalNum * belowZero) ? (finalNum * belowZero) : 0
}
reverse(3040)

//MARK: - 9. 回文数
//判断一个整数是否是回文数.回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数.
func isPalindrome(_ x: Int) -> Bool {
    guard x >= 0 else {
        return false
    }
    guard (x % 10 != 0) || x == 0 else {
        return false
    }
    func digit(_ x: Int) -> Int {
        if x < 10 {
            return 1;
        } else {
            return 10 * digit(x / 10)
        }
    }
    func reversed(_ x: Int) -> Int {
        if x < 10 {
            return x
        } else {
            return (x % 10) * digit(x) + reversed(x / 10)
        }
    }
    return x == reversed(x)
}

isPalindrome(12233221)

//MARK: - 13. 罗马数字转整数
/*罗马数字包含以下七种字符: I, V, X, L, C, D 和 M
 I:1 V: 5 X: 10 L: 50 C: 100 D: 500 M: 1000
 例如, 罗马数字 2 写做 II ,即为两个并列的 1.12 写做 XII ,即为 X + II . 27 写做  XXVII, 即为 XX + V + II .
 通常情况下,罗马数字中小的数字在大的数字的右边.但也存在特例,例如 4 不写做 IIII,而是 IV.数字 1 在数字 5 的左边,所表示的数等于大数 5 减小数 1 得到的数值 4 .同样地,数字 9 表示为 IX.这个特殊的规则只适用于以下六种情况：
 I 可以放在 V (5) 和 X (10) 的左边,来表示 4 和 9.
 X 可以放在 L (50) 和 C (100) 的左边,来表示 40 和 90.
 C 可以放在 D (500) 和 M (1000) 的左边,来表示 400 和 900.
 给定一个罗马数字,将其转换成整数.输入确保在 1 到 3999 的范围内.
 */
func romanToInt(_ s: String) -> Int {
    func romanValue(_ roman: Character) -> Int {
        switch roman {
        case "I":
            return 1
        case "V":
            return 5
        case "X":
            return 10
        case "L":
            return 50
        case "C":
            return 100
        case "D":
            return 500
        case "M":
            return 1000
        default:
            return 0;
        }
    }
    var finalValue = 0
    var readyToReduce = 0
    let charArray = Array(s)
    for (index, char) in charArray.enumerated() {
        let value = romanValue(char)
        var nextValue: Int = 0
        if index + 1 < charArray.count {
            nextValue = romanValue(charArray[index + 1])
        }
        if value >= nextValue {
            finalValue = finalValue + value - readyToReduce
            readyToReduce = 0
        } else {
            readyToReduce = value
        }
    }
    return finalValue
}
romanToInt("MCMXCIV")

//MARK: - 14. 最长公共前缀
//编写一个函数来查找字符串数组中的最长公共前缀.如果不存在公共前缀,返回空字符串"".
func longestCommonPrefix(_ strs: [String]) -> String {
    guard strs.count > 0 else {
        return ""
    }
    guard strs.count > 1 else {
        return strs[0]
    }
    var tempStr = strs
    tempStr.sort { (str1, str2) -> Bool in
        return str1.count <= str2.count
    }
    let shortestStr = tempStr[0]
    guard shortestStr.count > 0 else {
        return ""
    }
    tempStr.remove(at: 0)
    var commonPrefix: String = ""
    for (index, char) in shortestStr.enumerated() {
        var hasCommon: Bool = true
        for str in tempStr {
            if !str.hasPrefix(commonPrefix.appending(String(char))) {
                hasCommon = false
                break
            }
        }
        if hasCommon && index + 1 <= shortestStr.count {
            commonPrefix.append(char)
        } else {
            break
        }
    }
    return commonPrefix
}
longestCommonPrefix(["acb","cba"])

//MARK: - 20. 有效的括号
/*给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串,判断字符串是否有效.
 左括号必须用相同类型的右括号闭合.
 左括号必须以正确的顺序闭合.
 注意空字符串可被认为是有效字符串.
 */
func isValid(_ s: String) -> Bool {
    func match(_ left: Character?, _ right: Character?) -> Bool {
        guard left != nil && right != nil else {
            return false
        }
        switch left {
        case "(":
            return right == ")"
        case "{":
            return right == "}"
        case "[":
            return right == "]"
        default:
            return false
        }
    }
    guard s.count >= 0 && s.count % 2 == 0 else {
        return false
    }
    var charStack: [Character] = []
    for char in s {
        if match(charStack.last, char) {
            charStack.removeLast()
        } else {
            charStack.append(char)
        }
    }
    return charStack.count == 0
}
isValid("{}()[]({)}")

//MARK: - 21. 合并两个有序链表
func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    guard l1 != nil else {
        return l2
    }
    guard l2 != nil else {
        return l1
    }
    return nil
}
