/*
　Alloy Analyzer入門
  Alloy Analyzerでのモデリングの流れ - 最小限のモデルを作る　

  Role Based Access Control
 
  author: Kenichi Kobayashi

*/

/* ユーザアカウント。
   0以上のロールをrolesとして持つ
*/
sig User {
  roles: set Role
}

/* ロール。Admin,Guestなど。
   0以上の権限を持つ
*/
sig Role {
  perms: set Permission
}

/* 割り当てられる権限。Read,Write,ReadWriteなど*/
sig Permission {}

/* あるユーザの持つ権限の集合を取得する */
fun permissions[u:User]:set Permission {
  u.roles.perms
}

/* runコマンドはpred(述語)を指定できる */
run {}
