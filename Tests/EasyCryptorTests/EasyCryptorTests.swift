import XCTest
@testable import EasyCryptor

final class EasyCryptorTests: XCTestCase {
    var cryptor: EazyCryptor!
    
    override func setUp() {
        super.setUp()
        cryptor = EazyCryptor()
    }
    
    override func tearDown() {
        cryptor = nil
        super.tearDown()
    }
    
    func test_encryptionDecryptionWithLatinCharacters() {
        let originalText = "HelloWorld123"
        let encryptedText = cryptor.encrypt(originalText)
        let decryptedText = cryptor.decrypt(encryptedText)
        
        XCTAssertEqual(decryptedText, originalText, "Decrypted text should match the original text")
    }
    
    func test_encryptionDecryptionWithCyrillicCharacters() {
        let originalText = "ПриветМир123"
        let encryptedText = cryptor.encrypt(originalText)
        let decryptedText = cryptor.decrypt(encryptedText)
        
        XCTAssertEqual(decryptedText, originalText, "Decrypted text should match the original text")
    }
    
    func test_encryptionWithMixedCharacters() {
        let originalText = "HelloПривет123"
        let encryptedText = cryptor.encrypt(originalText)
        let decryptedText = cryptor.decrypt(encryptedText)
        
        XCTAssertEqual(decryptedText, originalText, "Decrypted text should match the original text")
    }
    
    func test_emptyTextEncryptionDecryption() {
        let originalText = ""
        let encryptedText = cryptor.encrypt(originalText)
        let decryptedText = cryptor.decrypt(encryptedText)
        
        XCTAssertEqual(decryptedText, originalText, "Decrypted text should match the original empty text")
    }
    
    func test_textWithSpecialCharacters() {
        let originalText = "TextWith!@#$%^&*()_+{}[]|;:,.<>?/`~"
        let encryptedText = cryptor.encrypt(originalText)
        let decryptedText = cryptor.decrypt(encryptedText)
        
        XCTAssertEqual(decryptedText, originalText, "Decrypted text should match the original text with special characters")
    }
}
