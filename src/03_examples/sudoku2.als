/*
  数独9*9

http://sudoku.ara3.net/problem/1/s0001.htm
9, , , ,8, , , ,5
 ,7, , , ,9, ,4, 
 , ,6, , ,3,2, , 
 ,2,1, , , , , , 
8, , , , , , , ,7
 , , , , , ,5,9, 
 , ,4,7, , ,3, , 
 ,8, ,6, , , ,1, 
2, , , ,5, , , ,8

  4*4と同じモデルを9*9に拡張して実施すると・・・

*/
sig Cell {
	x:Int,
	y:Int,
	v:Int
} {
	x >= 0 and x <= 8 
	y >= 0 and y <= 8 
	v >= 1 and v <= 9
}

fact AllCellsPosition {
	no disj c1,c2:Cell | c1.x == c2.x and c1.y == c2.y
	no disj c1,c2:Cell | c1.x == c2.x and c1.v == c2.v
	no disj c1,c2:Cell | c1.y == c2.y and c1.v == c2.v
}

/*セルのグループの値制約全体*/
pred AllCellGroupConstraint {
	CellGroup[0,0]
	CellGroup[3,0]
	CellGroup[6,0]

	CellGroup[0,3]
	CellGroup[3,3]
	CellGroup[6,3]

	CellGroup[0,6]
	CellGroup[3,6]
	CellGroup[6,6]	
}

/*セルのグループの値制約*/
pred CellGroup[xmin,ymin:Int] {
	no disj c1,c2:Cell |
		xmin <= c1.x and c1.x <= xmin + 2 and
		xmin <= c2.x and c2.x <= xmin + 2 and
		ymin <= c1.y and c1.y <= ymin + 2 and
		ymin <= c2.y and c2.y <= ymin + 2 and
		c1.v == c2.v
}

/*特定の位置のセルの値を設定する*/
pred value[x',y',v':Int] {
	one c:Cell | c.x == x' and c.y == y' and c.v == v'
}


fact Values {
	value[0,0,9] and value[4,0,8] and value[8,0,5]
	value[1,1,7] and value[5,1,9] and value[7,1,4]
	value[2,2,6] and value[5,2,3] and value[6,2,2]
	value[1,3,2] and value[2,3,1]
	value[0,4,8] and value[8,4,7]
	value[6,5,5] and value[7,5,9]
	value[2,6,4] and value[3,6,7] and value[6,6,3]
	value[1,7,8] and value[3,7,6] and value[8,7,1]
	value[0,8,2] and value[4,8,5] and value[8,8,8]
}

run AllCellGroupConstraint for 7 int, exactly 81 Cell
