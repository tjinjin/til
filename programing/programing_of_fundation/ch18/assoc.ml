(* サンプルデータ *)
let eki_list1 = [("新大塚", 1.2); ("後楽園", 1.8)]
let eki_list2 = [("新大塚", 1.2); ("後楽園", 1.8)]

(* 目的: 駅名と駅名と距離のリストを受け取り、その駅までの距離を返す *)
(* assoc : string -> (string * float) list -> float*)
let rec assoc eki eki_list = match eki_list with
    [] -> raise Not_found
  | (eki0, kyori) :: rest ->
      if eki = eki0 then kyori
      else assoc eki rest

(* test *)
let test1 = assoc "後楽園" eki_list1 = 1.8
let test2 = assoc "池袋" eki_list2 = infinity
let test1 = assoc "後楽園" [] = infinity
