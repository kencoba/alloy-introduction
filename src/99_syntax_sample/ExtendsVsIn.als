/*
 * Example : extends vs in
 *
 *author: Kenichi Kobayashi
 */
abstract sig Human {}
sig Man,Woman extends Human {}

abstract sig Employee {}
sig Sales,Engineer in Employee{}

/*
これはそもそもできない。extendsの場合、ManかつWomanはない
pred Bisexual {
       some m:Man | m in Woman
}
run Bisexual
*/

/*
Salesの要素であり、かつEngineerの要素でもある人を見つける
*/
pred AdditionalPost {
       some s:Sales | s in Engineer
}
run AdditionalPost
