/*
AさんとBさんがいて、少なくとも一人は赤い帽子を被っていて、
赤い帽子を被っていない人は白い帽子を被っている。
ただし、二人とも他人の帽子の色は分かるが、自分の被っている
帽子の色は分からない。そして、Aさんが「自分の帽子の色が分からない」と発言した。
このとき、Bさんの被っている帽子の色は何か?　
そして、Bさんは自分の被っている帽子の色が分かるか?
*/
-- 世界
sig W {
   K_a: set W, -- 「Aさんが知っている」という様相の到達可能性関係
   K_b: set W, -- 「Bさんが知っている」という様相の到達可能性関係
}

-- 命題: 世界の集合を外延として持つ。
abstract sig Prop { ext: set W }

-- Aさんが赤い帽子を被っているという命題
one sig A_wears_a_redhat extends Prop { }

-- Bさんが赤い帽子を被っているという命題
one sig B_wears_a_redhat extends Prop { }

-- 公理
fact {
   -- K_aは同値関係(K_aはS5様相)
   all w1 : W | all w2 : W {
      (w2 in w1.*K_a or w1 in w2.K_a) implies w2 in w1.K_a
   }

   -- K_bは同値関係(K_bはS5様相)
   all w1 : W | all w2 : W {
      (w2 in w1.*K_b or w1 in w2.K_b) implies w2 in w1.K_b
   }

   all w : W {
      -- どちらかの帽子は赤である
      (w in A_wears_a_redhat.ext or w in B_wears_a_redhat.ext)

      -- AさんはBさんの帽子の色を知っている
      (all w1 : w.K_a | w1 in B_wears_a_redhat.ext) or
      (all w1 : w.K_a | not (w1 in B_wears_a_redhat.ext))

      -- BさんはAさんの帽子の色を知っている
      (all w1 : w.K_b | w1 in A_wears_a_redhat.ext) or
      (all w1 : w.K_b | not (w1 in A_wears_a_redhat.ext))

      -- Aさんは自分の帽子の色が分からない
      not (all w1 : w.K_a | w1 in A_wears_a_redhat.ext)
      not (all w1 : w.K_a | not (w1 in A_wears_a_redhat.ext))
   }

   -- 世界は一つ以上存在
   #W > 0
}

--まずモデルが存在すること(無矛盾であること)をチェックする
pred show() { }
run show for 10 W

/*
B_wears_a_redhatが成り立っている世界があるので、
Bさんの帽子がちゃんと決まるとしたら、それは赤の帽子。
なので、assertとcheckを使って反例がないかをチェックする。
*/
assert test1 {
   all w : W | w in B_wears_a_redhat.ext
}
check test1 for 10

--Bさんが「自分は赤い帽子を被っている」ことを知っているかもチェック。
assert test2 {
   all w : W | all w1 : w.K_b | w1 in B_wears_a_redhat.ext
}
check test2 for 10
