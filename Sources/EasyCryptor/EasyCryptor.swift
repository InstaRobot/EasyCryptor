import Foundation

public struct EazyCryptor {
    private let check = "end"
    private var characters = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    private let separator = "~"

    public init() {}

    // Encrypt data
    public func encrypt(_ text: String) -> String {
        let text = text + check
        var enText = [String]()
        for char in text {
            if let unicodeValue = char.unicodeScalars.first?.value {
                enText.append(
                    forLoopGenHelper(
                        char: char, 
                        value: Int(unicodeValue)
                    )
                )
            }
        }
        return enText.joined()
    }

    // Decrypt data
    public func decrypt(_ text: String) -> String {
        let textArray = text.components(separatedBy: separator)
        var arrWord = [String]()
        
        for subText in textArray {
            arrWord.append(
                forLoopChkHelper(
                    w: String(subText)
                )
            )
        }
        let text = arrWord.joined()
        
        if let range = text.range(of: check) {
            return String(text[..<range.lowerBound])
        } 
        else {
            return ""
        }
    }

    // Helper function for encryption
    private func forLoopGenHelper(char: Character, value: Int) -> String {
        let letLen = characters.count - 1
        var sum = 0
        var ordval = [Int]()
        var chrval = [Character]()

        while true {
            if sum > value {
                ordval.removeLast()
                chrval.removeLast()

                let fval = value - ordval.reduce(0, +)
                if let fvalChar = characters.character(at: fval) {
                    ordval.append(fval)
                    chrval.append(fvalChar)
                }
                return String(chrval) + separator
            } 
            else {
                let rand = Int.random(in: 0...letLen)
                ordval.append(rand)
                if let rantx = characters.character(at: rand) {
                    chrval.append(rantx)
                }
                sum = ordval.reduce(0, +)
            }
        }
    }

    // Helper function for decryption
    private func forLoopChkHelper(w: String) -> String {
        var ntr = [Int]()
        for char in w {
            if let index = characters.firstIndex(of: char) {
                ntr.append(characters.distance(from: characters.startIndex, to: index))
            }
        }
        let sum = ntr.reduce(0, +)
        if let scalar = UnicodeScalar(sum) {
            return String(scalar)
        } 
        else {
            return ""
        }
    }
}

extension String {
    func character(at index: Int) -> Character? {
        guard index >= 0 && index < self.count else {
            return nil
        }
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}
