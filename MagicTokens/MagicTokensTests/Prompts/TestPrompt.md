#  TestPrompt

ANALYZE the provided class and CREATE a unit test class following THESE PATTERNS:

TEST CONTEXT:

Use XCTest structure

Import using @testable import MagicTokens

Class name: NomeDaClasseTests

SUT (System Under Test): sut

Mocks for all external dependencies

Do NOT create the mocks

Setup must manage lifecycle

Do NOT include tearDown

Test names in camelCase, no underscores

STRUCTURE:

import XCTest
@testable import MagicTokens

final class NomeDaClasseTests: XCTestCase {
    var sut: NomeDaClasse!
    var dependency1Mock: TipoDependency1Mock!
    
    override func setUp() {
        super.setUp()
            dependency1Mock = TipoDependency1Mock()
        sut = NomeDaClasse(dependency1: dependency1Mock)
    }
    
    func testMetodoCenarioResultadoEsperado() {
        // Given
        // When  
        // Then
    }
}


RULES:

Mocks must implement the same protocols

Mocks track calls (callCount, receivedParameters)

Test names in camelCase

Generate ONLY the test class code

DO NOT POLLUTE THE RESPONSE WITH ANYTHING I DID NOT ASK FOR!!!!!!!

TARGET CLASS:
