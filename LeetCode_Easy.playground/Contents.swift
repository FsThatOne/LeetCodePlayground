import Foundation
import Darwin

//MARK: - 1. 两数之和
//给定一个整数数组和一个目标值,找出数组中和为目标值的两个数的下标.你可以假设每个输入只对应一种答案,且同样的元素不能被重复利用.
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    guard nums.count >= 2 else {
        return []
    }
    var hashTable: [Int: Int] = [:]
    
    for i in 0..<nums.count {
        let tempValue = target - nums[i]
        if let tempIndex = hashTable[tempValue] {
            return [tempIndex, i]
        }
        hashTable[nums[i]] = i
    }
    return []
}
//Time: O(n)   Space: O(n)
twoSum([3,2,4], 6)

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
//Time: O(n)    Space: O(1)
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
//Time: O(n)    Space: O(1)
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
//Time: O(n)    Space: O(1)
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
//Timer: O(n2)  Space: O(1)
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
//Time: O(n)    Space: O(n)
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
//Time: O(n)    Space: O(1)
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
//Time: O(n)    Space: O(1)
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
//Time: O(n)    Space: O(1)
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
//Time: O(n)    Space: O(1)
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
//Time: O(logN)    Space: O(1)
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
//Time: O(n)    Space: O(1)
countAndSay(12)

//MARK: - 53. 最大子序和
//给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
func maxSubArray(_ nums: [Int]) -> Int {
    guard nums.count > 0 else {
        return 0
    }
    guard nums.count > 1 else {
        return nums[0]
    }
    var maxSum = nums[0]
    var currentMax = nums[0]
    for i in 1..<nums.count {
        currentMax = currentMax > 0 ? currentMax + nums[i] : nums[i]
        maxSum = max(currentMax, maxSum)
    }
    return maxSum
}
//Time: O(n)    Space: O(1)
maxSubArray([-2,1,-3,4,-1,2,1,-5,4])

//MARK: - 58. 最后一个单词的长度
//给定一个仅包含大小写字母和空格 ' ' 的字符串，返回其最后一个单词的长度。如果不存在最后一个单词，请返回 0 。
func lengthOfLastWord(_ s: String) -> Int {
    guard s.count > 0 else {
        return 0
    }
    var hasFindWord = false
    var length = 0
    
    for i in (0..<s.count).reversed() {
        if s[i] == " " {
            if hasFindWord {
                break
            } else {
                continue
            }
        } else {
            hasFindWord = true
            length += 1
        }
    }
    return length
}
//Time: O(n)    Space: O(1)
lengthOfLastWord("Hello World")

//MARK: - 66. 加一
/*给定一个由整数组成的非空数组所表示的非负整数，在该数的基础上加一。
最高位数字存放在数组的首位， 数组中每个元素只存储一个数字。
你可以假设除了整数 0 之外，这个整数不会以零开头。
*/
func plusOne(_ digits: [Int]) -> [Int] {
    guard digits.isEmpty != true else {
        return [1]
    }
    var returnArray = digits
    if let last = returnArray.popLast() {
        if last < 9 {
            returnArray.append(last + 1)
        } else {
            var final = plusOne(returnArray)
            final.append(0)
            return final
        }
    }
    return returnArray
}
//Time: O(n)    Space: O(n)
plusOne([9, 9, 9, 9, 9])

//MARK: - 67. 二进制求和
//给定两个二进制字符串，返回他们的和（用二进制表示）.输入为非空字符串且只包含数字 1 和 0
func addBinary(_ a: String, _ b: String) -> String {
    guard a.count > 0, b .count > 0 else { return "0" }
    var aa = a
    var bb = b
    var mod = 0
    var sum = ""
    while aa.count > 0 || bb.count > 0 {
        var temp = mod
        if aa.count > 0 {
            temp += (Int(String(aa.removeLast())) ?? 0)
        }
        if bb.count > 0 {
            temp += (Int(String(bb.removeLast())) ?? 0)
        }
        if temp >= 2 {
            mod = 1
            sum = String(temp - 2) + sum
        } else {
            mod = 0
            sum = String(temp) + sum
        }
    }
    if mod > 0 {
        sum = String(mod) + sum
    }
    return sum
}
//Time: O(n)    Space: O(1)
addBinary("1001011", "101")
addBinary("1111", "1111")

//MARK: - 88. 合并两个有序数组 -TODO
//给定两个有序整数数组 nums1 和 nums2，将 nums2 合并到 nums1 中，使得 num1 成为一个有序数组。
func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    guard nums2.count > 0 else {
        return
    }
}

//MARK: - 169. 求众数
//给定一个大小为 n 的数组，找到其中的众数。众数是指在数组中出现次数大于 ⌊ n/2 ⌋ 的元素。
//你可以假设数组是非空的，并且给定的数组总是存在众数。
func majorityElement(_ nums: [Int]) -> Int {
    guard nums.count > 1 else {
        return nums.first!
    }
    let sortedNums = nums.sorted(by: <)
    var num: Int = nums.first!
    var count = 0
    for number in sortedNums {
        if number == num {
            count += 1
            if count > nums.count / 2 {
                return num
            }
        } else {
            num = number
            count = 1
        }
    }
    return num
}
majorityElement([3,2,3])

//MARK: - 189. 旋转数组
//给定一个数组，将数组中的元素向右移动 k 个位置，其中 k 是非负数。
func rotate(_ nums: inout [Int], _ k: Int) {
    guard nums.count > 1 else {
        return
    }
    let modK = k % nums.count
    guard modK > 0 else {
        return
    }
    if modK <= nums.count / 2 { //小于一半, 向右移动modK
        for _ in 1...modK {
            nums.insert(nums.popLast()!, at: 0)
        }
    } else { //大于一半, 向左移动count - modK
        for _ in 1...nums.count - modK {
            nums.append(nums.first!)
            nums.removeFirst()
        }
    }
}
var rotateArray = [1, 3, -5, 7, -4, 2]
//Time: O(n)    Space: O(1)
rotate(&rotateArray, 8)

//MARK: - 198. 打家劫舍
/*你是一个专业的小偷，计划偷窃沿街的房屋。每间房内都藏有一定的现金，影响你偷窃的唯一制约因素就是相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警。
 给定一个代表每个房屋存放金额的非负整数数组，计算你在不触动警报装置的情况下，能够偷窃到的最高金额。*/
func rob(_ nums: [Int]) -> Int {
    guard nums.count > 0 else {
        return 0
    }
    guard nums.count > 1 else {
        return nums[0]
    }
    var odd = 0
    var even = nums[0]
    var maxSum = 0
    var i = 2
    
    while i < nums.count {
        even += nums[i]
        odd += nums[i - 1]
        maxSum = max(odd, even)
        i += 2
    }
    if i == nums.count {
        odd += nums.last!
        maxSum = max(odd, even)
    }
    return maxSum;
}

//MARK: - 206. 反转链表
//反转一个单链表。
func reverseList(_ head: ListNode?) -> ListNode? {
    guard head != nil else {
        return head
    }
    guard head!.next != nil else {
        return head
    }
    var pre = head
    var cur = head!.next
    var next: ListNode?
    pre?.next = nil
    while cur != nil {
        next = cur!.next
        cur!.next = pre
        pre = cur
        cur = next
    }
    return pre
}
//Time: O(n)    Space: O(1)
let listNode = LinkListGenerate([1, 3, 4, 8, 2, 5])
reverseList(listNode)?.output()

//MARK: - 225. 用队列实现栈
/*使用队列实现栈的下列操作：

push(x) -- 元素 x 入栈
pop() -- 移除栈顶元素
top() -- 获取栈顶元素
empty() -- 返回栈是否为空
注意:

你只能使用队列的基本操作-- 也就是 push to back, peek/pop from front, size, 和 is empty 这些操作是合法的。
你所使用的语言也许不支持队列。 你可以使用 list 或者 deque（双端队列）来模拟一个队列 , 只要是标准的队列操作即可。
你可以假设所有操作都是有效的（例如, 对一个空的栈不会调用 pop 或者 top 操作）。*/

//Time: O(1)    Space: O(1)
let aStack = MyStack<Int>()
aStack.push(8)
aStack.push(5)
aStack.pop()
aStack.top()
aStack.pop()
aStack.empty()

//MARK: - 605. 种花问题 -TODO
/*假设你有一个很长的花坛，一部分地块种植了花，另一部分却没有。可是，花卉不能种植在相邻的地块上，它们会争夺水源，两者都会死去。给定一个花坛（表示为一个数组包含0和1，其中0表示没种植花，1表示种植了花），和一个数 n 。能否在不打破种植规则的情况下种入 n 朵花？能则返回True，不能则返回False。*/
func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
    guard flowerbed.count > 0 else { return n == 0 }
    var fixedFlowers = [0] + flowerbed + [0]
    var sum = 0
    var index = 1
    while index <= flowerbed.count {
        if fixedFlowers[index - 1] == fixedFlowers[index], fixedFlowers[index] == fixedFlowers[index + 1] {
            if fixedFlowers[index] == 0 {
                sum += 1
                index += 2
            } else {
                index += 3
            }
        } else if fixedFlowers[index - 1] == fixedFlowers[index + 1] {
            if fixedFlowers[index - 1] == 0 {
                index += 2
            } else {
                index += 3
            }
        } else {
            index += 1
        }
    }
    return sum >= n
}
//Time: O(n)    Space: O(n)
canPlaceFlowers([1,0,0,0,1], 1)

//MARK: - 1030. 距离顺序排列矩阵单元格
/*
给出 R 行 C 列的矩阵，其中的单元格的整数坐标为 (r, c)，满足 0 <= r < R 且 0 <= c < C。
另外，我们在该矩阵中给出了一个坐标为 (r0, c0) 的单元格。
返回矩阵中的所有单元格的坐标，并按到 (r0, c0) 的距离从最小到最大的顺序排，其中，两单元格(r1, c1) 和 (r2, c2) 之间的距离是曼哈顿距离，|r1 - r2| + |c1 - c2|。（你可以按任何满足此条件的顺序返回答案。）*/
func allCellsDistOrder(_ R: Int, _ C: Int, _ r0: Int, _ c0: Int) -> [[Int]] {
    guard r0 < R, c0 < C else { return [[Int]]() }
    var tupleArray = [(Int, Int)]()
    (0..<R).map { row in
        (0..<C).map { column in
            tupleArray.append((row, column))
        }
    }
    tupleArray.sort { (tuple1, tuple2) -> Bool in
        return (abs(tuple1.0 - r0) + abs(tuple1.1 - c0)) < (abs(tuple2.0 - r0) + abs(tuple2.1 - c0))
    }
    let distanceArray = tupleArray.map {
        return [$0.0, $0.1]
    }
    return distanceArray
}
//Time: O(n)    Space: O(n)
allCellsDistOrder(2, 3, 1, 2)
