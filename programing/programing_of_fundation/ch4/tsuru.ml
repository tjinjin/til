(* 目的：鶴と亀の数の合計と足の数が与えられたら、鶴の数を返す *)
(* tsurukame : int -> int -> int *)
let tsurukame x y = (2 * x) - (y / 2)
(* answer *)
(* let tsurukame gokei ashi = (gokei * 4 - ashi)/2 *)


(* test *)
let test1 = tsurukame 2 6 = 1
let test2 = tsurukame 11 38 = 3
let test3 = tsurukame 20 46 = 17
