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
    var firstListPoint: ListNode? = l1
    var secondListPoint: ListNode? = l2
    var newListHead: ListNode = ListNode(0)
    var newListPoint = newListHead
    
    func compareList(_ left: inout ListNode?, _ right: inout ListNode?) {
        if left == nil {
            newListPoint.val = right!.val
            right = right!.next
        } else if right == nil {
            newListPoint.val = left!.val
            left = left!.next
        } else {
            if left!.val <= right!.val {
                newListPoint.val = left!.val
                left = left!.next
            } else {
                newListPoint.val = right!.val
                right = right!.next
            }
        }
    }
    while firstListPoint != nil || secondListPoint != nil {
        newListPoint.next = ListNode(0);
        newListPoint = newListPoint.next!
        compareList(&firstListPoint, &secondListPoint)
    }
    return newListHead.next
}
mergeTwoLists(LinkListGenerate([1, 2, 5, 6]), LinkListGenerate([1, 3, 4, 7]))

//MARK: - 26. 删除排序数组中的重复项
/*给定一个排序数组，你需要在原地删除重复出现的元素，使得每个元素只出现一次，返回移除后数组的新长度。
 不要使用额外的数组空间，你必须在原地修改输入数组并在使用 O(1) 额外空间的条件下完成。
 */
func removeDuplicates(_ nums: inout [Int]) -> Int {
    guard nums.count > 0 else {
        return 0
    }
    var preInt = nums[0]
    var deleteNumCount = 0
    
    for (index, num) in nums.enumerated() {
        guard index > 0 else {
            continue
        }
        if num == preInt {
            deleteNumCount += 1
            nums.remove(at: index - deleteNumCount)
        } else {
            preInt = num
        }
    }
    return nums.count
}
var duplicateIntArray = [0,0,1,1,1,2,2,3,3,4]
removeDuplicates(&duplicateIntArray)

//MRK: - 27. 移除元素
/*给定一个数组 nums 和一个值 val，你需要原地移除所有数值等于 val 的元素，返回移除后数组的新长度。
 不要使用额外的数组空间，你必须在原地修改输入数组并在使用 O(1) 额外空间的条件下完成。
 元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。
 */
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    guard nums.count > 0 else {
        return 0
    }
    var hasRemoveCount = 0
    for (index, num) in nums.enumerated() {
        if num == val {
            nums.remove(at: index - hasRemoveCount)
            hasRemoveCount += 1
        }
    }
    return nums.count
}
var removeIntArray = [0,0,1,1,1,2,2,3,3,4]
removeElement(&removeIntArray, 2)

//MARK: - 28. 实现strStr()
/*实现 strStr() 函数。
 给定一个 haystack 字符串和一个 needle 字符串，在 haystack 字符串中找出 needle 字符串出现的第一个位置 (从0开始)。如果不存在，则返回  -1。
 */
func strStr(_ haystack: String, _ needle: String) -> Int {
    guard needle.count > 0 else {
        return 0
    }
    guard haystack.count > 0 else {
        return -1
    }
    guard haystack.count >= needle.count else {
        return -1
    }
    var hayStackCopy = haystack
    var matchIndex = -1
    var removeCount = 0
    while hayStackCopy.count >= needle.count {
        if hayStackCopy.hasPrefix(needle) {
            matchIndex = removeCount
            break
        } else {
            removeCount += 1
            hayStackCopy.removeFirst()
        }
    }
    return matchIndex
}
strStr("hello", "ll")
strStr("aaaaa", "bba")

//MARK: - 35. 搜索插入位置
/*给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。
 你可以假设数组中无重复元素。
 */
func searchInsert(_ nums: [Int], _ target: Int) -> Int {//二分法
    func inner_searchInsert(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        for i in 0..<nums.count {
            if nums[i] == target {
                return i
            } else if nums[i] < target && nums[i+1] > target {
                return i + 1
            }
        }
        return 0
    }
    guard nums.count > 0 else {
        return 0
    }
    guard nums.count > 1 else {
        return target > nums[0] ? 1 : 0
    }
    guard nums.last! >= target else {
        return nums.count
    }
    guard nums.count >= 5 else {
        return inner_searchInsert(nums, target)
    }
    let middle: Int = (nums.count - 1)/2
    if nums[middle] == target {
        return middle
    } else if nums[middle] > target {
        return searchInsert(Array(nums[0..<middle]), target)
    } else {
        return searchInsert(Array(nums[(middle + 1)...nums.count - 1]), target) + middle + 1
    }
}
searchInsert([1,3,5,6], 7)

//MARK: - 38. 报数
/*报数序列是一个整数序列，按照其中的整数的顺序进行报数，得到下一个数
 https://leetcode-cn.com/problems/count-and-say/description/
*/
func countAndSay(_ n: Int) -> String {
    func matchAndReplace(_ str: String) -> String {
        var tempStr: String = str
        var returnStr = ""
        while tempStr.count > 0 {
            if tempStr.hasPrefix("111") {
                returnStr.append("31")
                tempStr = String(tempStr[tempStr.index(tempStr.startIndex, offsetBy: 3)...])
            } else if tempStr.hasPrefix("11") {
                returnStr.append("21")
                tempStr = String(tempStr[tempStr.index(tempStr.startIndex, offsetBy: 2)...])
            } else if tempStr.hasPrefix("1") {
                returnStr.append("11")
                tempStr = String(tempStr[tempStr.index(tempStr.startIndex, offsetBy: 1)...])
            } else if tempStr.hasPrefix("222") {
                returnStr.append("32")
                tempStr = String(tempStr[tempStr.index(tempStr.startIndex, offsetBy: 3)...])
            } else if tempStr.hasPrefix("22") {
                returnStr.append("22")
                tempStr = String(tempStr[tempStr.index(tempStr.startIndex, offsetBy: 2)...])
            } else if tempStr.hasPrefix("2") {
                returnStr.append("12")
                tempStr = String(tempStr[tempStr.index(tempStr.startIndex, offsetBy: 1)...])
            } else if tempStr.hasPrefix("333") {
                returnStr.append("33")
                tempStr = String(tempStr[tempStr.index(tempStr.startIndex, offsetBy: 3)...])
            } else if tempStr.hasPrefix("33") {
                returnStr.append("23")
                tempStr = String(tempStr[tempStr.index(tempStr.startIndex, offsetBy: 2)...])
            } else if tempStr.hasPrefix("3") {
                returnStr.append("13")
                tempStr = String(tempStr[tempStr.index(tempStr.startIndex, offsetBy: 1)...])
            }
        }
        return returnStr
    }
    var str = "1"
    guard n > 1 else {
        return str
    }
    
    for _ in 1..<n {
        str = matchAndReplace(str)
    }
    return str
}
countAndSay(12)

//MARK: - 53. 最大子序和
//给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
func maxSubArray(_ nums: [Int]) -> Int {
    
    return 0
}
