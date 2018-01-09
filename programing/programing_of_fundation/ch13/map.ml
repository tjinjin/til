(* 目的：関数fとリストlstを受け取り、fを施したリストを返す*)
(* map : ('a -> 'b) -> 'a list -> 'b list *)
let rec map f lst = match lst with
    [] -> []
  | first :: rest -> f first :: map f rest

(* test *)
let test1 = map sqrt [2.0; 3.0] = [1.41421356237309515; 1.73205080756887719]
