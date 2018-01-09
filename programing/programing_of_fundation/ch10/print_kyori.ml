(*補助関数*)
#use "book-data/ex10_10.ml"
#use "book-data/ex10_11.ml"

(* 目的：ローマ字の駅名を2つ受け取り、直接つながっている場合は距離を表示し、そうでない場合はそうでない旨を表示する*)
(* print_kyori.ml : string -> string -> string*)
let print_kyori eki1_r eki2_r = match (eki1_r, eki2_r) with
    ("", "") -> "error"
  | ("", eki2_r) -> "error"
  | (eki1_r, "") -> "error"
  | (eki1_r, eki2_r) ->
     (romaji_to_kanji eki1_r, romaji_to_kanji eki2_r) = match (a, b) with
        ("", "") -> eki1_r ^ "という駅は存在しません"
     | (a, "") -> eki2_r ^ "という駅は存在しません"
     | ("", b) -> eki1_r ^ "という駅は存在しません"
     | (a, b) -> if (get_ekikan_kyori a b) = infinity then a ^ "駅と" ^ b ^ "駅はつながっていません"
                 else a ^ "駅から" ^ b ^ "駅までは" ^ string_of_float (get_ekikan_kyori a b) ^ "kmです"

(* test *)
let test1 = print_kyori "myogadani" "shinotsuka" = "茗荷谷駅から新大塚駅までは1.2kmです"
let test2 = print_kyori "shinotsuka" "myogadani" = "新大塚駅から茗荷谷駅までは1.2kmです"
let test3 = print_kyori "shinotsuka" "gyotoku" = "茗荷谷駅と行徳駅はつながっていません"
let test4 = print_kyori "shinotsuka" "yamahahatsudouki" = "yamahahatsudoukiという駅は存在しません"
