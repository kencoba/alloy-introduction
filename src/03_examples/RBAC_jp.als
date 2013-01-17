/*
　Alloy Analyzer入門
  Alloy Analyzerでのモデリングの流れ - 最小限のモデルを作る　

  Role Based Access Control
 
  author: Kenichi Kobayashi

*/

/* ユーザアカウント。
   0以上のロールをrolesとして持つ
*/
sig ユーザ {
  所有ロール: set ロール
}

/* ロール。Admin,Guestなど。
   0以上の権限を持つ
*/
sig ロール {
  所有権限: set 権限
}

/* 割り当てられる権限。Read,Write,ReadWriteなど*/
sig 権限 {}

/* あるユーザの持つ権限の集合を取得する */
fun 権限取得[u:ユーザ]:set 権限 {
  u.所有ロール.所有権限
}

/* runコマンドはpred(述語)を指定できる */
run {}
