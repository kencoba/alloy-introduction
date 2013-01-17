abstract sig Name {}
sig Alias extends Name {}
sig Group extends Name {}
sig RecentlyUsed in Name {}

fun union []:set Name {
	Alias + Group
}

fun intersection []:set Name {
	Alias & RecentlyUsed
}

fun difference []:set Name {
	Name - RecentlyUsed
}

pred subset [] {
	RecentlyUsed in Alias
}

pred equality [] {
	Name = Group + Alias
}

pred show [] {
}

run show for 4
