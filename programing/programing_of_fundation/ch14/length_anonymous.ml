(* 目的：受け取ったリスト lstの長さを求める *)
(* length : 'a list -> int *)
let length lst =
  fold_right (fun first rest_result -> 1 + rest_result) lst 0

(* test *)
let test1 = length [1;2;3;4;5] = 5
let test2 = length ["a";"a";"a"] = 3
