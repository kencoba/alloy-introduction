/*
  Alloy Analyzer入門
  モデルを拡張する

  Role Based Access Control
  ロールに階層関係を追加

  author: Kenichi Kobayashi
*/

/* ユーザアカウント。
  0以上のロールを持つ。
*/
sig User {
	roles: set Role
}

/* ロール。Admin,Guestなど
  0以上の権限を持つ
  0以上の親のロールを持つ
 */
sig Role {
  perms: set Permission,
  superRoles: set Role
}

/*割り当てられる操作。Read,Write,ReadWriteなど*/
sig Permission {}

/* 不変制約
   ロールの階層構造がループしないこと。
*/
fact {
  no r:Role | r in r.^superRoles  
}

/* ロールが階層化されているため、
スーパーロールのパーミッションも取得する */
fun permissions[u:User]: set Permission {
	u.roles.*superRoles.perms
}

/* ユーザにロールを付与する。 */
pred addRole[u,u':User,r:Role] {
	u'.roles = u.roles + r
}

/* ユーザからロールを剥奪する。 */
pred removeRole[u,u':User,r:Role] {
	u'.roles = u.roles - r
}

/* ロールに権限を付与する。 */
pred addPermission[r,r':Role,p:Permission] {
	r'.perms = r.perms + p
}

/* ロールから権限を剥奪する。 */
pred removePermission[r,r':Role,p:Permission] {
	r'.perms = r.perms - p
}

/* ロールを追加して削除したのならば、操作前と後では同じロールを持つはず
  ただし、集合演算では、既に集合に入っている要素の追加も許されるため、
  no (u.roles)を追加する。
 */
assert AddAndRemoveRole {
	all disj u,u',u'':User,r:Role |
       no (u.roles) and addRole[u,u',r] and removeRole[u',u'',r]
       implies permissions[u] = permissions[u'']
}

check AddAndRemoveRole
