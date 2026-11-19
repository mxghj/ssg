package main

import "core:fmt"
import "core:os"
import "core:strings"

convertTokensToHTML :: proc(tokens: [dynamic]token) -> string {
	html := "<!DOCTYPE html>\n<html>\n<body>\n"
	for token in tokens {
		start: string
		end: string
		#partial switch token.kind {
		case tokenKind.Heading1:
			start = "<h1> "
			end = "</h1> "
		case tokenKind.Heading2:
			start = "<h2> "
			end = "</h2> "
		case tokenKind.Heading3:
			start = "<h3> "
			end = "</h3> "
		case tokenKind.Heading4:
			start = "<h4> "
			end = "</h4> "
		case tokenKind.Heading5:
			start = "<h5> "
			end = "</h5> "
		case tokenKind.Heading6:
			start = "<h6> "
			end = "</h6> "
		case tokenKind.Paragraph:
			start = "<p> "
			end = "</p> "
		case tokenKind.Bold:
			start = "<strong> "
			end = "</strong> "
		case tokenKind.Italic:
			start = "<em> "
			end = "</em> "
		case tokenKind.BoldItalic:
			start = "<em><strong> "
			end = "</strong></em> "
		case tokenKind.Blockquotes:
			start = "<blockquote> "
			end = "</blockquote> "
		}
		tk: string
		tk = strings.concatenate({tk, start})
		tk = strings.concatenate({tk, token.text})
		tk = strings.concatenate({tk, end})
		tk, _ = strings.replace_all(tk, "\n", "<br>")
		html = strings.concatenate({html, tk})
	}
	html = strings.concatenate({html, "\n</body>\n</html>"})
	return html
}
