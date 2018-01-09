(* あらかじめ ex10_11.ml, ex12_1.ml を読み込んでおく必要あり *)
#use "book_data/ex10_11.ml" (* get_ekikan_kyori の定義 *)
#use "book_data/ex12_1.ml" (* eki_t の定義 *)

(* 目的：未確定の駅のリスト v を必要に応じて更新したリストを返す *)
(* koushin : eki_t -> eki_t list -> ekikan_t list -> eki_t list *)
let koushin p v ekikan_list =
  List.map (fun q -> match (p, q) with
	     ({namae = pn; saitan_kyori = ps; temae_list = pt},
	      {namae = qn; saitan_kyori = qs; temae_list = qt}) ->
		let kyori = get_ekikan_kyori pn qn ekikan_list in
		if kyori = infinity
		then q
		else if ps +. kyori < qs
		then {namae = qn; saitan_kyori = ps +. kyori;
				  temae_list = qn :: pt}
		else q)
	   v

(* 駅の例 *)
let eki1 = {namae="池袋"; saitan_kyori = infinity; temae_list = []}
let eki2 = {namae="新大塚"; saitan_kyori = 1.2; temae_list = ["新大塚"; "茗荷谷"]}
let eki3 = {namae="茗荷谷"; saitan_kyori = 0.; temae_list = ["茗荷谷"]}
let eki4 = {namae="後楽園"; saitan_kyori = infinity; temae_list = []}

(* 駅リストの例 *)
let lst = [eki1; eki2; eki3; eki4]

(* テスト *)
let test1 = koushin eki2 [] global_ekikan_list = []
let test2 = koushin eki2 lst global_ekikan_list =
 [{namae="池袋"; saitan_kyori = 3.0; temae_list = ["池袋"; "新大塚"; "茗荷谷"]};
  eki2; eki3; eki4]
