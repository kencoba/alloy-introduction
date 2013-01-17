sig Group {}
sig Alias {}
sig Addr {}

fun address [] : set univ -> univ {
	Group -> Alias + Group -> Group + Alias -> Addr	
}

fun domain_restriction []: set univ -> univ {
	address :> Alias
}

fun range_restriction []: set univ -> univ {
	Group <: address
}

pred show [] {
	#Alias = 3
	#Group = 2
	#Addr = 3
}

run show for 4
