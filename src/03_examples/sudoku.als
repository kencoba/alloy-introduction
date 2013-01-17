/*
  数独4*4

  0,0,0,4
  0,0,1,2
  0,1,4,3
  4,3,2,1

  を解く。4*4ならば、このモデルでも
  無理の無い時間内に解を求めることができる

*/

sig Cell {
	x:Int,
	y:Int,
	v:Int
} {
	x >= 0 and x <= 3 
	y >= 0 and y <= 3 
	v >= 1 and v <= 4
}

fact AllCellsPosition {
	no disj c1,c2:Cell | c1.x == c2.x and c1.y == c2.y
	no disj c1,c2:Cell | c1.x == c2.x and c1.v == c2.v
	no disj c1,c2:Cell | c1.y == c2.y and c1.v == c2.v
}

fact Values {
	one c:Cell | c.x == 3 and c.y == 0 and c.v == 4

	one c:Cell | c.x == 2 and c.y == 1 and c.v == 1
	one c:Cell | c.x == 3 and c.y == 1 and c.v == 2

	one c:Cell | c.x == 1 and c.y == 2 and c.v == 1
	one c:Cell | c.x == 2 and c.y == 2 and c.v == 4
	one c:Cell | c.x == 3 and c.y == 2 and c.v == 3

	one c:Cell | c.x == 0 and c.y == 3 and c.v == 4
	one c:Cell | c.x == 1 and c.y == 3 and c.v == 3
	one c:Cell | c.x == 2 and c.y == 3 and c.v == 2
	one c:Cell | c.x == 3 and c.y == 3 and c.v == 1
}

run {} for exactly 16 Cell 
