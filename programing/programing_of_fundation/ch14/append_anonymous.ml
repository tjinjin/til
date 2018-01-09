(* 目的：lst1 と lst2を受け取りそれらを結合したリストを返す *)
(* append : 'a list -> 'a list -> 'a list *)
let append =
  fold_right (fun first rest_result -> first :: rest_result)
            lst1 lst2
