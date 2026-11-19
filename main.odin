package main

import "core:os"
import "core:fmt"

main :: proc() {
    if len(os.args) == 2 {
        data, err_1 := os.read_entire_file(os.args[1], context.allocator)
		if err_1 != nil {
			panic("Can't open the file")
		}
		defer delete(data, context.allocator)
		text := string(data)
		code := convertTokensToHTMLCSS(lexicalAnalysis(text))
		err_2 := os.write_entire_file("index.html", transmute([]byte)(code))
        if err_2 != nil {
            panic("Can't write the file \"index.html\"")
        }
    } else do fmt.println("Usage:\n     ssg <md file path>")
}
