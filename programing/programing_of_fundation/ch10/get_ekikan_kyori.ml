(* 定義を読み込む*)
#use "book-data/ex09_10.ml"

(* 目的：漢字の駅名を2つ受け取り、その駅間の距離を返す *)
(* get_ekikan_kyori: string -> string -> ekikan_t list -> float*)
let rec get_ekikan_kyori name1 name2 global_ekikan_list = match (name1, name2) with
    ("", "") -> infinity
  | ("", name2) -> infinity
  | (name1, "") -> infinity
  | (name1, name2) -> match global_ekikan_list with
        [] -> infinity
      | {kiten=k;shuten=s;keiyu=ke;kyori=ky;jikan=j} :: rest ->
        if k = name1 && s = name2 || k = name2 && s = name1 then ky
        else get_ekikan_kyori name1 name2 rest

(* test *)
let test1 = get_ekikan_kyori "" "茗荷谷" global_ekikan_list = infinity
let test2 = get_ekikan_kyori "茗荷谷" "" global_ekikan_list = infinity
let test3 = get_ekikan_kyori "茗荷谷" "新大塚" global_ekikan_list = 1.2
let test4 = get_ekikan_kyori "新大塚" "茗荷谷" global_ekikan_list = 1.2
let test5 = get_ekikan_kyori "霞ヶ関" "大手町" global_ekikan_list = infinity
let test6 = get_ekikan_kyori "妙典" "茗荷谷" global_ekikan_list = infinity
let test7 = get_ekikan_kyori "" "" global_ekikan_list = infinity
