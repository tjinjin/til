(* 目的：受け取ったリスト lst の各要素の和を求める *)
(* sum : int list -> int *)
let sum lst =
  fold_right (fun first rest_result -> first + rest_result)
            lst 0
