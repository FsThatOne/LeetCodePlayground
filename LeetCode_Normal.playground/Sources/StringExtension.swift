import Foundation

//扩展String的下标
public extension String {
    subscript(index: Int) -> Character? {
        guard index < self.count else {
            return nil
        }
        let charIndex = self.index(self.startIndex, offsetBy: index)
        return self[charIndex]
    }
    
    //获取子字符串
    func subStringInRange(_ r: Range<Int>) -> String? {
        if r.lowerBound < 0 || r.upperBound > self.count {
            return nil
        }
        let startIndex = self.index(self.startIndex, offsetBy:r.lowerBound)
        let endIndex   = self.index(self.startIndex, offsetBy:r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    func subStringInRange(_ r: ClosedRange<Int>) -> String? {
        if r.lowerBound < 0 || r.upperBound > self.count {
            return nil
        }
        let startIndex = self.index(self.startIndex, offsetBy:r.lowerBound)
        let endIndex   = self.index(self.startIndex, offsetBy:r.upperBound)
        return String(self[startIndex...endIndex])
    }
}
