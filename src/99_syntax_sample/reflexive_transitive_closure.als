sig Name {
	to: set Name
}

fun reflexive_transitive_clojure []:set Name -> Name {
	*to
}

pred show [] {}

run show for 4 but 4 Name
