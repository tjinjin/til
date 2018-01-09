(* 目的：虚数解があるか判定する *)
(* kyosuukai : float -> float -> float -> bool *)
let kyosuukai a b c =
  if (hanbetsushiki a b c) < 0.0 then true else false


(* 目的：判別式の値を返す*)
(* hanbetsushiki : float -> float -> float -> float *)
let hanbetsushiki a b c =
  (b ** 2.0) -. (4.0 *. a *. c)

(* test *)
let test1 = kyosuukai 3.0 6.0 2.0 = false
let test2 = kyosuukai 1.0 (-4.0) 4.0 = false
let test3 = kyosuukai 3.0 2.0 10.0 = true
