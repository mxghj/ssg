package main

import "core:fmt"

print_tokens :: proc(tokens: [dynamic]token) {
    for token in tokens {
        fmt.println("Kind: ", token.kind, " - text: ", token.text)
    }
}

main :: proc() {
    fmt.println("Lexical analysis of \"## Hello\"")
    print_tokens(lexicalAnalysis("## Hello"))
}
