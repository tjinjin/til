(* あらかじめ ex12_1.ml を読み込んでおく必要あり *)
#use "book-data/ex12_1.ml" (* eki_t の定義 *)

(* 目的：受け取った駅のリストを、最短距離最小の駅とそれ意外に分離する *)
(* saitan_wo_bunri : eki_t list -> eki_t * eki_t list *)
let saitan_wo_bunri eki_list = match eki_list with
  List.fold_right (
      if fs < ss then (first, p :: v)
      else (p, first :: v)
    ) eki_list ""

(* 駅の例 *)
let eki1 = {namae="池袋"; saitan_kyori = infinity; temae_list = []}
let eki2 = {namae="新大塚"; saitan_kyori = 1.2; temae_list = ["新大塚"; "茗荷谷"]}
let eki3 = {namae="茗荷谷"; saitan_kyori = 0.; temae_list = ["茗荷谷"]}
let eki4 = {namae="後楽園"; saitan_kyori = infinity; temae_list = []}

(* 駅リストの例 *)
let lst = [eki1; eki2; eki3; eki4]

(* テスト *)
let test = saitan_wo_bunri lst = (eki3, [eki1; eki2; eki4])
