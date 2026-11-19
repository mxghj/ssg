package main

import "core:strings"

convertTokensToHTMLCSS :: proc(tokens: [dynamic]token) -> string {
    html := "<!DOCTYPE html>\n<html>\n<head><title>Hello</title>\n<link href='https://fonts.googleapis.com/css?family=IBM Plex Mono' rel='stylesheet'/>\n</head>\n<style>\n.content {\nfont-size: 1.09375rem;\nwidth: 100%;\ncolor: #C5C8C6;\ntext-align: center;\nfont-family: IBM Plex Mono;\n}\nbody\n{\n\nbackground-color: #080808;\n}\n</style>\n<body>\n<div class=\"content\">\n<p>"
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
	html = strings.concatenate({html, "\n</p>\n</div>\n</body>\n</html>"})
	return html
}
