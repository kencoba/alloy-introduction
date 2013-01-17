/*
	Name: {(N0),(N1),(N2)}
	Address: {(D0),(D1),(D2)}
	addr:{(N0,D0),(N1,D1),(N2,D1)}
*/
sig Name {
	addr: one Address
}
sig Address {}

assert functional_but_not_injective {
	all a:Address | a in Name.addr 
}

check functional_but_not_injective for 4
