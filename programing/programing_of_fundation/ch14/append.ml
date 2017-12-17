(* 目的：first をリスト rest_result の先頭に加える *)
(* cons : 'a -> 'a list -> 'a list*)
let cons first rest_result = first :: rest_result

(* 目的：lst1 と lst2を受け取りそれらを結合したリストを返す *)
(* append : 'a list -> 'a list -> 'a list *)
let append lst1 lst2 = fold_right cons lst1 lst2

(* test *)
let test1 = append [] [1] = [1]
let test2 = append [1;2] [3;4] = [1; 2; 3; 4]
