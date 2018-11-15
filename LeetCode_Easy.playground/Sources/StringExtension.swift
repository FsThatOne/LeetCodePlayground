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
}
