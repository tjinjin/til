(* 目的：学生のリスト lst を受け取り成績を入れたリストを返す *)
(* map_hyouka: gakusei_t list -> gakusei_t list *)
let rec map_hyouka lst = match lst with
    [] -> []
  | first :: rest -> hyouka first :: map_hyouka rest
