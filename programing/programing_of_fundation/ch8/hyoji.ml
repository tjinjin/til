(* ekimei_t型*)
#use "ch8/ekimei_t.ml"

(* 目的：ekimei_tを受け取り整形して出力する *)
(* ekimei_t -> string *)
let hyoji ekimei = match ekimei with
{kanji=a;kana=b;romaji=c;shozoku=d} ->
  d ^ "，" ^ a ^ "（" ^ b ^ "）"

(* test *)
let test1 = hyoji {kanji="茗荷谷";kana="みょうがだに";romaji="myogadani";shozoku="丸ノ内線"}
  = "丸ノ内線，茗荷谷（みょうがだに）"
