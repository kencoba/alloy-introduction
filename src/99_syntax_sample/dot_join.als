sig Mail {
	to:one Name
}
sig Name {
	address: one Addr
}
sig Addr {}

fun dot_join []:set univ -> univ {
    // ここでtoは (Mail,Name) , addressは(Name,Addr)
	// なのでdot joinにより、 (Mail,Addr)が返る
	to.address
}


pred show [] {
}

run show for 4
