// hello_world

include "libc/stdio"


// set by the machine trap handler
@alias("__mtrap_flag")
public var mtrapFlag: @volatile Int32 = 0


func main () -> Int {
	printf("Hello World!\n")

	if mtrapFlag != 0 {
		printf("Machine trap occurred!\n")
	} else {
		printf("No machine trap occurred.\n")
	}

	return 0
}


// This function is called when a machine trap occurs.
// It is defined in the assembly file vect.S and linked to the mtvec register.
@alias("__isr")
public func isr () -> Unit {
	mtrapFlag = 1
}


