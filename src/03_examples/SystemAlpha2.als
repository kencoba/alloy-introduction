open util/ordering[State] as so
/*
4日で学ぶモデル検査
システムα
仕様：
　変数a
　　0->1 1->2 2->0と繰り返して変化する。
　　ただしb=1のときは次の時点でもその値を保ち変化しない。
　　初期状態は0とする。
　変数b
　　0->1 1->2 2->0と繰り返して変化する。
　　ただしb=aのときは次の時点でもその値を保ち変化しない。
　　初期状態は0とする。
　スイッチ
　　a=b=2 ならばon
	a=b=1 ならばoff
　　それ以外では次の時点でもその値を保ち変化しない。
　　初期状態はoffとする。


ループを形成するAtomは8と4であることを発見した
*/

abstract sig Switch {}
one sig On,Off extends Switch {}
abstract sig Number {}
one sig Zero,One,Two extends Number {}

sig State {
	a: one Number,
	b: one Number,
	s: one Switch,
	nxt: one State
}
fact {
	first[so/first] &&
	( all pre: State - so/last | let post = so/next[pre] |
		trans[pre,post]
	)
}

pred first[st:State] {
	st.a = Zero and
	st.b = Zero and
	st.s = Off
}

pred trans[st,st':State] {
	st'.a = next_a[st.a,st.b] and
	st'.b = next_b[st.a,st.b] and
	st'.s = next_s[st.a,st.b,st.s] and
	st' = st.nxt
}

fun next_a[a,b:Number]:Number {
	{ n:Number |
		(b = One)  => n = a   else
		(a = Zero) => n = One else
		(a = One)  => n = Two else
		(a = Two)  => n = Zero
	}
}

fun next_b[a,b:Number]:Number {
	{n:Number |
		(a = b) => n = b else
		(b = Zero) => n = One else
		(b = One)  => n = Two else
		(b = Two)  => n = Zero
	}
}

fun next_s[a,b:Number,ss:Switch]:Switch {
	{ss':Switch |
		(a = b and a = Two) => ss' = On else
		(a = b and a = One) => ss' = Off else
		ss' = ss
	}
}

pred show[] {
	some disj ss,ss':State |
		ss.a = ss'.a and ss.b = ss'.b and ss.s = ss'.s
}

run show for 9
