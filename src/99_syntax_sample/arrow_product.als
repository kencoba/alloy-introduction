sig Name {}
sig Addr {}

fun arrow []:set univ->univ {
	Name -> Addr
}

pred show [] {
	#Name = 2
	#Addr = 2
}

run show for 5
