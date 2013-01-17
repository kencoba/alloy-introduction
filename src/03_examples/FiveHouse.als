/*
    それぞれ異なる色の、５つの建物が並んでいます。
    それらの家にはそれぞれ出身地の異なる家主が住んでいます。
    5人全てが、何か飲み物を飲み、タバコを吸い、ペットを飼っています。
    ただし、飲み物の種類、タバコの銘柄、ペットの種類はそれぞれべつべつです。
    問題： ↓の文を読み、誰が魚を飼っているかを当てて下さい。
    １．日本人は赤い家に住んでいます。
    ２．アメリカ人は犬を飼っています。
    ３．中国人はお茶を飲みます。
    ４．緑の家は白い家の左にあります。
    ５．緑の家の家主はコーヒーを飲みます。
    ６．セブンスターを吸う家主は鳥を飼っています。
    ７．黄色い家の家主はマイルドセブンを吸っています。
    ８．ちょうど真ん中に位置する家の家主は牛乳を飲みます。
    ９．イタリア人は一番左の家に住んでいます。
    １０．マルボロを吸う家主の家のお隣さんは猫を飼っています。
    １１．馬を飼っている家主の家のお隣さんはマイルドセブンを吸っています。
    １２．ホープを吸っている家主はビールを飲みます。
    １３．ブラジル人はラークを吸っています。
    １４．青い家の隣の家にイタリア人は住んでいます。
    １５．マルボロを吸う家主の隣の家の家主は水を飲みます。
*/
open util/ordering[House] as ho

abstract sig House {
	color: one Color,
	habitant: one Person
}
sig Person {
	state: one State,
	drink: one Drink,
	smoke: one Tobacco,
	has: one Pet
}

abstract sig Color {}
one sig Red,Green,White,Yellow,Blue extends Color {}
abstract sig State {}
one sig Japan,USA,China,Italy,Brazil extends State {}
abstract sig Drink {}
one sig Tea,Coffee,Milk,Beer,Water extends Drink {}
abstract sig Tobacco {}
one sig SevenStar,MildSeven,Malboro,Hope,Lark extends Tobacco {}
abstract sig Pet {}
one sig Dog,Bird,Cat,Horse,Fish extends Pet {}

fun right[h:House]:House {ho/next[h]}
fun left[h:House]:House {ho/prev[h]}
fun center[]:House {right[right[leftmost]]}
fun rightmost[]:House {ho/last}
fun leftmost[]:House {ho/first}

fact HouseConstraint {all disj h,h':House | h.habitant != h'.habitant and h.color != h'.color}
fact PersonConstraint {all disj p,p':Person | p.state != p'.state and p.drink != p'.drink and p.smoke != p'.smoke and p.has != p'.has}

fact f1 {one h:House | h.color = Red and h.habitant.state = Japan}
fact f2 {one p:Person | p.state = USA and p.has = Dog}
fact f3 {one p:Person | p.state = China and p.drink = Tea}
fact f4 {one h,h':House | h.color = Green and h'.color = White and left[h'] = h}
fact f5 {one h:House | h.color = Green and h.habitant.drink = Coffee}
fact f6 {one p:Person | p.smoke = SevenStar and p.has = Bird}
fact f7 {one h:House | h.color = Yellow and h.habitant.smoke = MildSeven}
fact f8 {one h:House | h = center and h.habitant.drink = Milk}
fact f9 {one h:House | h = leftmost and h.habitant.state = Italy}
fact f10 {one h:House | h.habitant.smoke = Malboro and (left[h].habitant.has = Cat or right[h].habitant.has = Cat)}
fact f11 {one h:House | h.habitant.has = Horse and (left[h].habitant.smoke = MildSeven or right[h].habitant.smoke = MildSeven)}
fact f12 {one p:Person | p.smoke = Hope and p.drink = Beer}
fact f13 {one p:Person | p.state = Brazil and p.smoke = Lark}
fact f14 {one h:House | h.color = Blue and (left[h].habitant.state = Italy or right[h].habitant.state = Italy)}
fact f15 {one h:House | h.habitant.smoke = Malboro and (left[h].habitant.drink = Water or right[h].habitant.drink = Water)}

pred show {}

run show for 5
