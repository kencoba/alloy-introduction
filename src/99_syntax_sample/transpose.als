sig Mail {
	to:one Name
}
sig Name {
	address: one Addr
}
sig Addr {}

fun transpose1 []:set univ -> univ {
	~to
}

/*
fun transpose2 []:set univ -> univ -> univ {
	~(Mail -> Name -> Addr)
}*/


pred show [] {
}

run show for 4
