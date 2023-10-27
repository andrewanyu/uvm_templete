global env

if { $env(DUMP) == 1 } {
	fsdbDumpvars +all
	fsdbDumpvars 0
	fsdbDumpon
}

run