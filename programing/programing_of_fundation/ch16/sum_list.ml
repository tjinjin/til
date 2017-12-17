(* 目的：整数のリストを受け取り、それまでの合計からなるリストを返す *)
(* sum_list : int list -> int list*)
(* ここでtotalはこれまでの数値の合計 *)
let sum_list lst =
  let rec hojo lst total = match lst with
      [] -> []
    | first :: rest -> total + first :: hojo rest (total + first)
  in hojo lst 0

(*test*)
let test1 = sum_list [] = []
let test1 = sum_list [1;2;3;4] = [1;3;6;10]
let test1 = sum_list [3;2;4;1] = [3;5;9;10]
