(* 駅名のグラフ定義 *)
#use "ch12/eki_t.ml"
#use "book-data/ex09_9.ml"

(* 駅名リストの例 *)
let example_list = [
{kanji="池袋"; kana="いけぶくろ"; romaji="ikebukuro"; shozoku="丸ノ内線"};
{kanji="新大塚"; kana="しんおおつか"; romaji="shinotsuka"; shozoku="丸ノ内線"};
{kanji="茗荷谷"; kana="みょうがだに"; romaji="myogadani"; shozoku="丸ノ内線"};
{kanji="後楽園"; kana="こうらくえん"; romaji="korakuen"; shozoku="丸ノ内線"};
{kanji="本郷三丁目"; kana="ほんごうさんちょうめ"; romaji="hongosanchome"; shozoku="丸ノ内線"};
{kanji="御茶ノ水"; kana="おちゃのみず"; romaji="ochanomizu"; shozoku="丸ノ内線"}
]

(* 目的:eki_t のリストを返す *)
(* make_eki_list: ekimet_t list -> eki_t list *)
let rec make_eki_list lst = match lst with
    [] -> []
  | ({kanji=k; kana=kn; romaji=r; shozoku=s}) as first :: rest ->
      {namae=k; saitan_kyori=infinity; temae_list=[]} :: make_eki_list rest

(* test *)
let test1 = make_eki_list [] = []
let test2 = make_eki_list global_ekimei_list = [{namae = ""; saitan_kyori=infinity; temae_list=[]}]

(* テスト *)
let test1 = make_eki_list [] = []
let test2 = make_eki_list example_list = [
{namae="池袋"; saitan_kyori = infinity; temae_list = []};
{namae="新大塚"; saitan_kyori = infinity; temae_list = []};
{namae="茗荷谷"; saitan_kyori = infinity; temae_list = []};
{namae="後楽園"; saitan_kyori = infinity; temae_list = []};
{namae="本郷三丁目"; saitan_kyori = infinity; temae_list = []};
{namae="御茶ノ水"; saitan_kyori = infinity; temae_list = []}
]
