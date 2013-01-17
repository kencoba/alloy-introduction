sig Name {
	to: set Name
}

fun transitive_clojure []:set Name -> Name {
	^to
}

pred show [] {}

run show for 4
