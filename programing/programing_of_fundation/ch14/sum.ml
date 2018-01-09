(* fold_right を利用する*)
#use "ch14/fold_right.ml"

(* 目的 : first と rest_resultを加える*)
(* add_int : int -> int-> int*)
let add_int first rest_result = first + rest_result

(* 目的：受け取ったリスト lst の各要素の和を求める*)
(* sum: int list -> *)
let sum lst = fold_right add_int lst 0

(* test *)
let test1 = sum [1;2;3] = 6
