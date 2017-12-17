(* あらかじめ ex08_5.ml, ex12_1.ml を読み込んでおく必要あり *)
#use "book-data/ex08_5.ml"
#use "book-data/ex12_1.ml"

(* 駅名リストの例 *)
let ekimei_list = [
{kanji="池袋"; kana="いけぶくろ"; romaji="ikebukuro"; shozoku="丸ノ内線"};
{kanji="新大塚"; kana="しんおおつか"; romaji="shinotsuka"; shozoku="丸ノ内線"};
{kanji="茗荷谷"; kana="みょうがだに"; romaji="myogadani"; shozoku="丸ノ内線"};
{kanji="後楽園"; kana="こうらくえん"; romaji="korakuen"; shozoku="丸ノ内線"};
{kanji="本郷三丁目"; kana="ほんごうさんちょうめ"; romaji="hongosanchome"; shozoku="丸ノ内線"};
{kanji="御茶ノ水"; kana="おちゃのみず"; romaji="ochanomizu"; shozoku="丸ノ内線"}
]

(* 目的: 駅名リストから初期化した駅リストを作る *)
(* make_initial_eki_list.ml: ekimei_t list -> string -> eki_t list *)
let make_initial_eki_list ekimei_list kiten =
    List.map (fun ekimei -> match ekimei with
      {kanji = k; kana = a; romaji = r; shozoku = s} ->
        if k = kiten
        then {namae = k; saitan_kyori = 0.; temae_list = [k]}
        else {namae = k; saitan_kyori = infinity; temae_list = []})
    ekimei_list

(* テスト *)
let test1 = make_initial_eki_list [] "茗荷谷" = []
let test2 = make_initial_eki_list ekimei_list "茗荷谷" = [
{namae="池袋"; saitan_kyori = infinity; temae_list = []};
{namae="新大塚"; saitan_kyori = infinity; temae_list = []};
{namae="茗荷谷"; saitan_kyori = 0.; temae_list = ["茗荷谷"]};
{namae="後楽園"; saitan_kyori = infinity; temae_list = []};
{namae="本郷三丁目"; saitan_kyori = infinity; temae_list = []};
{namae="御茶ノ水"; saitan_kyori = infinity; temae_list = []}
]
