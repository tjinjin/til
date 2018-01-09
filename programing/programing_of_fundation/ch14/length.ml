(* 目的：firstは無視してrest_result に 1 を加える *)
(* add_one : int -> int -> int *)
let add_one first rest_result = 1 + rest_result

(* 目的：受け取ったリスト lstの長さを求める *)
(* length : 'a list -> int *)
let length lst = fold_right add_one lst 0

(* test *)
let test1 = length [1;2;3;4;5] = 5
let test2 = length ["a";"a";"a"] = 3
