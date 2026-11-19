package main

tokenKind :: enum u8 {
	Heading1,
	Heading2,
	Heading3,
	Heading4,
	Heading5,
	Heading6,
	Paragraph,
	Italic,
	Bold,
	BoldItalic,
	Blockquotes,
}

token :: struct {
	text: string,
	kind: tokenKind,
}

isDelimiter :: proc(ch: u8) -> bool {
	return ch == '#' || ch == '*' || ch == '<'
}

lexicalAnalysis :: proc(input: string) -> [dynamic]token {
	tokens: [dynamic]token
	start_i, end_i: int

	for (end_i + 1 < len(input)) {
		switch input[end_i] {
		case '#':
			heading_level: int
			for input[end_i] == '#' && end_i + 1 < len(input) {
				heading_level += 1
				end_i += 1
			}
			heading_type := (tokenKind)(heading_level - 1)
			start_i = end_i
			for (end_i + 1 < len(input) && !isDelimiter(input[end_i])) {
				end_i += 1
			}
			text := string(input[start_i:end_i + 1])
			append(&tokens, token{text, heading_type})
		case '<':
			end_i += 1
			start_i = end_i
			for (end_i + 1 < len(input) && !isDelimiter(input[end_i])) {
				end_i += 1
			}
			text := string(input[start_i:end_i + 1])
			append(&tokens, token{text, tokenKind.Blockquotes})
		case '*':
			star_amount_start: int
			for input[end_i] == '*' && end_i + 1 < len(input) {
				star_amount_start += 1
				end_i += 1
			}
			star_type := (tokenKind)(star_amount_start + 6)
			start_i = end_i
			for (end_i + 1 < len(input)) {
				end_i += 1
				if input[end_i] == '*' {
					star_amount_end: int
					for input[end_i] == '*' && end_i + 1 < len(input) {
						star_amount_end += 1
						end_i += 1
					}
					if star_amount_start == star_amount_end do break
				}
			}
			text := string(input[start_i:end_i - star_amount_start + 1])
			append(&tokens, token{text, star_type})
		case:
		    start_i = end_i
			for (end_i + 1 < len(input) && !isDelimiter(input[end_i])) {
			    end_i+=1
			}
			text := string(input[start_i:end_i - start_i + 1])
			append(&tokens, token{text, tokenKind.Paragraph})
		}
	}
	return tokens
}
