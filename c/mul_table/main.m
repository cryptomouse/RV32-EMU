// mul_table

include "libc/stdio"


const n: Int32 = 9


// printf из sys не поддерживает ширину поля, поэтому выравниваем вручную
func printNum (x: Int32, width: Int32) -> Unit {
	var digits: Int32 = 1
	var y = x
	while y >= 10 {
		y = y / 10
		digits = digits + 1
	}

	var i = digits
	while i < width {
		printf(" ")
		i = i + 1
	}

	printf("%d", x)
}


func main () -> Int {
	printf("Multiplication table %dx%d\n\n", n, n)

	// header
	printf("   |")
	var j: Int32 = 1
	while j <= n {
		printNum(j, width=4)
		++j
	}
	printf("\n")

	printf("---+")
	j = 1
	while j <= n {
		printf("----")
		++j
	}
	printf("\n")

	// rows
	var i: Int32 = 1
	while i <= n {
		printNum(i, width=2)
		printf(" |")
		j = 1
		while j <= n {
			printNum(i * j, width=4)
			++j
		}
		printf("\n")
		++i
	}

	return 0
}


