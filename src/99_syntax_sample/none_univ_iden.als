/*

*/
pred empty_set [] {
	#none > 0
}

//run empty_set for 4

sig Unit {}
sig Value {}

pred univ_set [] {
 	some u:Unit | u not in univ
 	some v:Value | v not in univ
}

//run univ_set for 4

pred iden_set  [] {
	some disj r,r':univ | r -> r' in iden
}

//run iden_set for 4

