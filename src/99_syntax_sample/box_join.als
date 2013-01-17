sig Mail {
	to:one Name
}
sig Name {
	address: one Addr
}
sig Addr {}

fun box_join []:set univ -> univ {
	address[to]
}


pred show [] {
}

run show for 4
