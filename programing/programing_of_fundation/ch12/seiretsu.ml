(* あらかじめ、ekimei_t型を読み込んでおく *)
#use "book-data/ex08_5.ml"

(* 駅名リストの例 *)
let example_list = [
{kanji="池袋"; kana="いけぶくろ"; romaji="ikebukuro"; shozoku="丸ノ内線"};
{kanji="池袋"; kana="いけぶくろ"; romaji="ikebukuro"; shozoku="有楽町線"};
{kanji="新大塚"; kana="しんおおつか"; romaji="shinotsuka"; shozoku="丸ノ内線"};
{kanji="茗荷谷"; kana="みょうがだに"; romaji="myogadani"; shozoku="丸ノ内線"};
{kanji="後楽園"; kana="こうらくえん"; romaji="korakuen"; shozoku="丸ノ内線"};
{kanji="本郷三丁目"; kana="ほんごうさんちょうめ"; romaji="hongosanchome"; shozoku="丸ノ内線"};
{kanji="御茶ノ水"; kana="おちゃのみず"; romaji="ochanomizu"; shozoku="丸ノ内線"}
]

(* 目的：補助関数 *)
(* ekimei_insert : ekimei_t list -> ekimei_t -> ekimei_t [] *)
let rec ekimei_insert lst n = match lst with
    [] -> [n]
  | ({kanji=kj;kana=kn;romaji=r;shozoku=s} as first) :: rest ->
      match n with
      {kanji=nkj;kana=nkn;romaji=nr;shozoku=ns} ->
        if kn < nkn then first :: ekimei_insert rest n
        else if kn > nkn then n :: lst
        (* 昇順にソート済み前提なのでkn> nknとなった場合には前につけるだけ *)
        else ekimei_insert rest n


(* 目的: 駅名リストを受け取り、それをひらがな順でソートし、重複を取り除く *)
(* seiretsu : ekimei_t list -> ekimei_t list *)
let rec seiretsu lst = match lst with
    [] -> []
  | {kanji=kj;kana=kn;romaji=r;shozoku=s} as first :: rest ->
      ekimei_insert (seiretsu rest) first


(*test*)
let test1 = seiretsu example_list = [
{kanji="池袋"; kana="いけぶくろ"; romaji="ikebukuro"; shozoku="丸ノ内線"};
{kanji="御茶ノ水"; kana="おちゃのみず"; romaji="ochanomizu"; shozoku="丸ノ内線"};
{kanji="後楽園"; kana="こうらくえん"; romaji="korakuen"; shozoku="丸ノ内線"};
{kanji="新大塚"; kana="しんおおつか"; romaji="shinotsuka"; shozoku="丸ノ内線"};
{kanji="本郷三丁目"; kana="ほんごうさんちょうめ"; romaji="hongosanchome"; shozoku="丸ノ内線"};
{kanji="茗荷谷"; kana="みょうがだに"; romaji="myogadani"; shozoku="丸ノ内線"}
]
let test2 = seiretsu [] = []
