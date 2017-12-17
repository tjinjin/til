(* 目的：判別式の値を返す*)
(* hanbetsushiki : float -> float -> float -> float *)
let hanbetsushiki a b c =
  (b ** 2.0) -. (4.0 *. a *. c)

(* test *)
let test1 = hanbetsushiki 3.0 6.0 2.0 = 12.0
let test2 = hanbetsushiki 1.0 (-4.0) 4.0 = 0.0
let test3 = hanbetsushiki 3.0 2.0 10.0 = (-29.0)
