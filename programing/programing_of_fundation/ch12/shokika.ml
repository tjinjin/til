(* あらかじめ ex12_1.ml を読み込んでおく必要あり *)
#use "book-data/ex12_1.ml"

(* 駅名リストの例 *)

let eki_list = [
{namae="池袋"; saitan_kyori = infinity; temae_list = []};
{namae="新大塚"; saitan_kyori = infinity; temae_list = []};
{namae="茗荷谷"; saitan_kyori = infinity; temae_list = []};
{namae="後楽園"; saitan_kyori = infinity; temae_list = []};
{namae="本郷三丁目"; saitan_kyori = infinity; temae_list = []};
{namae="御茶ノ水"; saitan_kyori = infinity; temae_list = []}
]

(* 目的：駅名リストから始点駅の距離を0化するのと、temae_listを始点駅のみのリストにしたい*)
(* shokika : eki_t list -> string -> eki_t list *)
let rec shokika eki_list kiten = match eki_list with
    [] -> []
  | ({namae = k; saitan_kyori = s; temae_list = t} as first) :: rest ->
      if k = kiten
      then {namae = k; saitan_kyori = 0.; temae_list = [k]}
	   :: shokika rest kiten
      else first :: shokika rest kiten

(* テスト *)
let test1 = shokika [] "茗荷谷" = []
let test2 = shokika eki_list "茗荷谷" = [
{namae="池袋"; saitan_kyori = infinity; temae_list = []};
{namae="新大塚"; saitan_kyori = infinity; temae_list = []};
{namae="茗荷谷"; saitan_kyori = 0.; temae_list = ["茗荷谷"]};
{namae="後楽園"; saitan_kyori = infinity; temae_list = []};
{namae="本郷三丁目"; saitan_kyori = infinity; temae_list = []};
{namae="御茶ノ水"; saitan_kyori = infinity; temae_list = []}
]
