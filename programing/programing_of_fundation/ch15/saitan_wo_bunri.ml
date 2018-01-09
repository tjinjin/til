(* あらかじめ ex10_11.ml, ex12_1.ml を読み込んでおく必要あり *)
#use "book-data/ex10_11.ml"
#use "book-data/ex12_1.ml"

(* 駅の例 *)
let eki1 = {namae="池袋"; saitan_kyori = 3.0; temae_list = ["池袋"; "新大塚"; "茗荷谷"]}
let eki2 = {namae="新大塚"; saitan_kyori = 1.2; temae_list = ["新大塚"; "茗荷谷"]}
let eki3 = {namae="茗荷谷"; saitan_kyori = 0.; temae_list = ["茗荷谷"]}
let eki4 = {namae="後楽園"; saitan_kyori = infinity; temae_list = []}

(* eki_t listを受け取り、「最短距離最小の駅」と「最短距離最小の駅以外からなるリスト」の組を返す *)
(* saitan_wo_bunri : eki_t list -> eki_t * eki_t list*)
let rec saitan_wo_bunri lst = match lst with
    [] -> ({namae="";saitan_kyori=infinity;temae_list=[]}, [])
  | first :: rest ->
      let (p, v) = saitan_wo_bunri rest in
      match (first, p) with
        ({namae=fn;saitan_kyori=fs;temae_list=ft},
         {namae=sn;saitan_kyori=ss;temae_list=st}) ->
           if sn = "" then (first, v)
           else if fs < ss then (first, p :: v)
           else (p, first :: v)

