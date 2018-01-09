(* あらかじめ sect18_1/price.ml を読み込んでおく必要あり *)
#use "sect18_1/price.ml"

(* yaoya_list のサンプル *)
(* 八百屋においてある野菜と値段のリストの例 *)
let yaoya_list = [("トマト", 300); ("たまねぎ", 200);
                  ("にんじん", 150); ("ほうれん草", 200)]

(* 目的野菜がどこのお店にも置いてない数を数える *)
(* count_urikire_yasai: string list -> (string * int) list -> int *)
let rec count_urikire_yasai yasai_list yaoya_list = match yasai_list with
    [] -> 0
  | first :: rest ->
      match price first yaoya_list with
        None -> 1 + count_urikire_yasai rest yaoya_list
      | Some (p) -> count_urikire_yasai rest yaoya_list

(* テスト *)
let test1 = count_urikire_yasai ["トマト"; "にんじん"] yaoya_list = 0
let test2 = count_urikire_yasai ["じゃがいも"; "たまねぎ"; "にんじん"] yaoya_list = 1
