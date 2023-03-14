import Foundation
struct ProductionRule {
    var predecessor: Character
    var successor: String
}

struct LSystem {
    var alphabet: Set<Character>
    var axiom: Character 
    var productionRules: [ProductionRule]
}


let productionRules = [ProductionRule(predecessor:"1", successor:"11"),
                       ProductionRule(predecessor:"0", successor:"1[0]0")]
let lSystem = LSystem(alphabet:["0", "1", "[", "]"], axiom:"0", productionRules:productionRules)

//0&1
func nonTerminals() -> Set<Character> {
    var nonTerminals =  Set<Character>() 
    var pr = lSystem.productionRules 
    for character in lSystem.alphabet {
        for rule in pr {
            if rule.predecessor == character {
                nonTerminals.insert(character)
            }
        }
    }
    return nonTerminals
}

//[&]
func terminals() -> Set<Character> {
    var terminals = Set<Character>()
    var pr = lSystem.productionRules
    var found = false
    for character in lSystem.alphabet {
        for rule in pr {
            if rule.predecessor == character {
                found = true
            }
        }
        if found == false {
            terminals.insert(character)
        }
        found = false
    }
    return terminals  

}

func produce(generationCount:Int) -> String {

    if generationCount == 0 {
        return String(lSystem.axiom)
    }else {
        var terminalChars = terminals()
        //nonTerminalChars = nonTerminals()
        var result = produce(generationCount:generationCount-1)
        //sub result
        var newResult = ""
        for character in result {
            if terminalChars.contains(character) {
                newResult.append(character)
            }else{
                newResult.append(getSub(character:character))

            }
        }
        return newResult
    }
}

func getSub(character:Character) -> String {
    for pr in productionRules {
        if pr.predecessor == character {
            return pr.successor
        }
    }
    return String(character)
}


var result =  produce(generationCount:7)
print(result)
