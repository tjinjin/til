(* 目的：x, yを受け取ったらその中点の座標を返却する *)
(* (int * int) * (int * int) -> (int * int) *)
let chuten ((x, y), (a, b)) =
  ((x + a)/2, (y + b)/2)

(* test *)
let test1 = chuten ((2, 10),  (6, 2))  = (4, 6)
let test2 = chuten ((-4, 10), (6, 2))  = (1, 6)
let test3 = chuten ((-2, -4), (10, 8)) = (4, 2)

(*
答え:パターンマッチを入れ子にできるっぽい
let chuten point1 point2 = match point1 with
  (x1, y1) -> (match point2 with
		(x2, y2) -> ((x1 +. x2) /. 2.0, (y1 +. y2) /. 2.0))
*)
