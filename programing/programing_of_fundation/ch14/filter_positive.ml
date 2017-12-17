(* 目的:受け取ったリスト lst から正の要素のみを取り出す *)
(* fllter_positive: int list -> int list *)
let rec filter_positive lst = match lst with
    [] -> []
  | first :: rest ->
      if first > 0 then first :: filter_positive rest
      else filter_positive rest
