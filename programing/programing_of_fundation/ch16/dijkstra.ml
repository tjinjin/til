(* あらかじめ関数やレコードを読み込んでおく必要あり *)
#use "book-data/ex10_10.ml" (* romaji_to_kanji *)
#use "book-data/ex16_4.ml"  (* dijkstra_main *)

(* 目的：ekimei list から eki list を作る *)
(* make_initial_eki_list : ekimei_t list -> string -> eki_t list *)
let make_initial_eki_list ekimei_list kiten =
  List.map (fun ekimei -> match ekimei with
	     {kanji = k; kana = a; romaji = r; shozoku = s} ->
	       if k = kiten
	       then {namae = k; saitan_kyori = 0.; temae_list = [k]}
	       else {namae = k; saitan_kyori = infinity; temae_list = []})
	   ekimei_list


(* 目的：受け取った eki_list から shuten のレコードを探し出す *)
(* find : string -> eki_t list -> eki_t *)
let rec find shuten eki_list = match eki_list with
    [] -> {namae = ""; saitan_kyori = infinity; temae_list = []}
  | ({namae = n; saitan_kyori = s; temae_list = t} as first) :: rest ->
      if n = shuten then first else find shuten rest

(* 目的：始点の駅名(ローマ字) と終点の駅名（ローマ字）を受け取り, 終点までの距離と経由駅を示す *)
(* dijkstra : string -> string -> eki_t *)
let dijkstra romaji_kiten romaji_shuten =
  let kiten = romaji_to_kanji romaji_kiten global_ekimei_list in
  let shuten = romaji_to_kanji romaji_shuten global_ekimei_list in
  let eki_list = make_initial_eki_list global_ekimei_list kiten in
  let eki_list2 = dijkstra_main eki_list global_ekikan_list in
  find shuten eki_list2

(* test *)
let test1 = dijkstra "shibuya" "gokokuji" =
  {namae = "護国寺"; saitan_kyori = 9.8;
   temae_list =
     ["護国寺"; "江戸川橋"; "飯田橋"; "市ヶ谷"; "麹町"; "永田町";
      "青山一丁目"; "表参道"; "渋谷"]}
let test2 = dijkstra "myogadani" "meguro" =
  {namae = "目黒"; saitan_kyori = 12.7000000000000028;
   temae_list =
     ["目黒"; "白金台"; "白金高輪"; "麻布十番"; "六本木一丁目"; "溜池山王";
      "永田町"; "麹町"; "市ヶ谷"; "飯田橋"; "後楽園"; "茗荷谷"]}


