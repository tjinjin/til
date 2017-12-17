(* 目的: 5教科の得点から合計点と平均点を計算する *)
(* int -> (int * int * int * int * int) -> (int * int) *)
let goukei_to_heikin (a, b, c, d, e) =
  (a + b + c + d + e, (a + b + c + d + e) / 5)
(* test *)
let test1 = goukei_to_heikin (10, 10, 10, 10, 10) = (50, 10)
let test2 = goukei_to_heikin (100, 100, 100, 100, 100) = (500, 100)
let test3 = goukei_to_heikin (95, 45, 80, 75, 65) = (360, 72)
