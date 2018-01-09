(* あらかじめ ex17_12.ml を読み込んでおく必要あり *)
#use "book-data/ex17_12.ml" (* insert_tree の定義 *)

(* 目的：駅間の木と駅間リストを受け取りリストを木に変換する *)
(* inserts_ekikan *)
let rec inserts_ekikan ekikan_tree lst = match lst with
    [] -> ekikan_tree
  | first :: rest ->
      inserts_ekikan (insert_ekikan ekikan_tree first) rest
