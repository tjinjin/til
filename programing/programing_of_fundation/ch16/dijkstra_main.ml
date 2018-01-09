(* 利用する関数を読み込んでおく *)
  (* 目的：未確定の駅のリスト v を必要に応じて更新したリストを返す *)
  (* koushin : eki_t -> eki_t list -> ekikan_t list -> eki_t list *)
#use "book-data/ex16_3.ml"

  (* 目的：受け取った駅のリストを、最短距離最小の駅とそれ以外に分離する *)
  (* saitan_wo_bunri : eki_t list -> eki_t * eki_t list *)
#use "book-data/ex15_5.ml"


(* 未確定の駅リストと駅間リストを受け取ったら最短距離と最短経路が正しく入ったリストを返す *)
(* dijkstra_main : eki_t list -> ekikan_t list -> eki_t list -> eki_list*)
let rec dijkstra_main eki_list ekikan_list u_list = match eki_list with
    [] -> u_list
  | first :: rest ->
      let v_list =
      dijkstra_main rest ekikan_list
    (saitan_wo_bunri (koushin first eki_list ekikan_list)) = match (u, v) with
      u -> u :: u_list
      v -> v_list


