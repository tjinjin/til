(* priceを読み込む *)
#use "ch18/price.ml"

(*さんぷる*)

(*目的 : yasai_list を飼ったときの値段の合計を調べる *)
(* total_price: string list -> (string * int) list -> int *)
let rec total_price yasai_list yaoya_list = match yasai_list with
    [] -> 0
  | first :: rest ->
      match price first yaoya_list with
        None -> total_price rest yaoya_list
      | Some (p) -> p + total_price rest yaoya_list

(* テスト *)
let test1 = total_price ["トマト"; "にんじん"] yaoya_list = 450
let test2 = total_price ["じゃがいも"; "たまねぎ"; "にんじん"] yaoya_list = 350
