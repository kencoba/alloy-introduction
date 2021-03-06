/*
Alloy Analyzerによるモデリング入門
演習課題「トレーニングコース申込システム」

  Step1: 問題記述を元に、モデルを作成し、runでインスタンスを生成してください。

1.概要
Formal Methods Education社(FME)は、
形式手法を中心としたシステム開発のコンサルティング会社です。
FMEでは定期的に、トレーニングコースを開催しています。
トレーニングコースの申込は、Web上から申込システムを使用することによって行います。


2.データモデル要素
トレーニングコースの申込システムのデータモデルは、
おおむね以下の要素から成り立ちます。

コース:トレーニングコースのマスタデータです。
ex. 
コースA(ID[1],コース名[Alloy Analyzer入門],標準受講料[15,000円])
コースB(ID[2],コース名[Coqで学ぶ定理証明],標準受講料[68,000円])

開催日程:コースに対する、具体的な各開催回です。
ex.
開催日程A(ID[11],コースID[1],開催[4月27日],会場[東京],受講料[15,000円])」
開催日程B(ID[12],コースID[1],開催[5月31日],会場[東京],受講料[15,000円])」
開催日程C(ID[13],コースID[2],開催[9月10日,11日],会場[名古屋],受講料[68,000円])」

日付:各開催日程と紐づく、年月日データです。
ex.
日付A(ID[201],日付[2013/5/31])
日付B(ID[202],日付[2013/9/10])
日付C(ID[203],日付[2013/9/11])

会場:各開催日程と紐づく、会場データです。
ex.
東京会場(ID[501],会場名[東京],定員[20名],会場住所[東京都新宿区2-1-1])
名古屋会場(ID[502],会場名[名古屋],定員[16名],会場住所[愛知県名古屋市1-2-2])

申込:各開催日程に対して、申込者が申し込むデータです。
ex.
申込1(ID[3],開催日程ID[1],申込日時[2013/1/11 12:30])

受講者:各申込に紐づく、受講者データです。
ex.
受講者1(ID[5],申込ID[3],氏名[奥山登])
受講者2(ID[6],申込ID[3],氏名[氷川透])


2.データ間の関係
1件のコースには、0件以上の開催日程が対応します。
1件の開催日程には、必ず1件のコースが対応します。
1件の開催日程には、1件以上の日付が対応します。
1件の開催日程には、必ず1件の開場が対応します。
1件の開催日程には、0件以上、会場定員以下の申込が対応します。
1件の申込には、1件以上5件以下の受講者が対応します。


3.申込システム運用者からの基本的要求
1. コースを指定することにより、コースに対応する開催日程一覧を取得したい
2. 開催日程を指定することにより、開催日程に対する申込に対応する受講者一覧を取得したい
3. 会場と日付を指定することにより、指定された会場と日付に対応する開催日程を取得したい


4. データに対する基本的制約
同一会場同一日付に対応する開催日程は、0または1件です。

*/

/*
  Step2: インスタンス数を制限するfactを追加してください。

  2.1 fact 各々の申込には最低一人最大五名の受講者が対応する
  2.2 fact 特定開催日程における申込数の合計は会場のキャパシティ以内であること
  2.3 fact 同一会場同一日付での複数開催日程は存在しない 

2.1の参考
fact 各々の申込には最低一人最大五名の受講者が対応する {
	all e:申込 | #(受講者_申込.e) > 0 and #(受講者_申込.e) < 6
}
*/

/*
  Step3: 下記のassertを追加し、checkをしてください。

  3.1 assert 一つの開催日程には一つのコースが対応する
  3.2 assert 開催日程に紐づかない申込は存在しないこと
  3.3 assert 申込に紐づかない受講者は存在しないこと
  3.4 assert 開催日程に紐づかない日付は存在しないこと

3.1の参考
assert 一つの開催日程には一つのコースが対応する {
	all s:開催日程 | one s.開催日程_コース
}
check 一つの開催日程には一つのコースが対応する
*/

/*
  Step4: データの取得操作をfun定義により追加してください。

  4.1 fun 開催日程取得[c:コース]: set 開催日程
  4.2 fun コース取得[s:開催日程]:set コース

  4.3 fun 開催日程取得[e:申込]: set 開催日程
  4.4 fun 申込取得[s:開催日程]: set 申込
  4.5 fun 日付取得[s:開催日程]: set 日付
  4.6 fun 会場取得[s:開催日程]: set 会場

  4.7 fun 開催日程取得[p:会場,d:日付]: set 開催日程

  4.8 fun 受講者取得[s:開催日程]: set 受講者
  4.9 fun 受講者取得[p:会場,d:日付]:set 受講者

4.1の参考
fun 開催日程取得[c:コース]:set 開催日程 {
	開催日程_コース.c
}
*/

/*
  Step5 操作前後のチェックをpredにより追加してください。

  5.1 pred 開催日程登録[c,c':コース,s:開催日程] // 同一会場、同一日付に別の開催日程が存在しなければ登録できる
  5.2 pred 申込登録[s,s':開催日程,e:申込,t:受講者] // 申込最大数未満であれば登録できる
  5.3 pred 開催日程削除[c,c':コース,s:開催日程] // 申込が存在しない開催日程のみ削除できる
  5.4 pred 会場削除[p:会場] // 開催日程が存在しない会場のみ削除できる

5.1の参考
pred 開催日程登録[c,c':コース,s:開催日程] {
	no t:開催日程 | t != s and t.開催日程_会場 = s.開催日程_会場 and t.開催日程_日付 = s.開催日程_日付 
	開催日程_コース.c' = 開催日程_コース.c + s
}
*/

/*
  オプション課題:追加仕様の検討

  Step6 セットコースを追加する
    コースをまとめて新たに一つのコースとする。
    ex: モデリングコースは{やさしい形式手法、Alloy Analyzer入門、Alloy Analyzer基礎}を一セットにしたコース

    モデリングの方針1: コースの階層構造を作る
    モデリングの方針2: プロジェクトとコースの2つに分ける(プロジェクト:コース= 1:n)

    注意点: セットコースの各日程は、独立した日程としても受講可能とする

  Step7 初日のみ受講コースを追加する
    ex: 「B-Method演習(2日間)」のうち、1日目は「B-Method入門(1日目)」コースとして販売する

  Step8 特定開催日程割引キャンペーンを実施する
    ex: 2月8日の「やさしい形式手法」のみ、50%引きとする

  Step9 優待IDを追加する
    ex: 優待ID:abcdefを付与して申し込んだ場合は50%引きとする

    注意点: 優待IDは、特定対象コースに対してのみ有効とする

  Step10 担当講師を追加する

*/
