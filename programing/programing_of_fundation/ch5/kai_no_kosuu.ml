(* 目的：解の個数を返す*)
(* kai_no_kosuu : float -> float -> float -> int *)
let kai_no_kosuu a b c =
  if (hanbetsushiki a b c) > 0.0 then 2
  else if (hanbetsushiki a b c) = 0.0 then 1
  else 0

(* 目的：判別式の値を返す*)
(* hanbetsushiki : float -> float -> float -> float *)
let hanbetsushiki a b c =
  (b ** 2.0) -. (4.0 *. a *. c)

(* test *)
let test1 = kai_no_kosuu 3.0 6.0 2.0 = 2
let test2 = kai_no_kosuu 1.0 (-4.0) 4.0 = 1
let test3 = kai_no_kosuu 3.0 2.0 10.0 = 0
