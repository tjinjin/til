(* ekimei_t の構造*)
#use "book-data/ex08_5.ml"
#use "book-data/ex09_9.ml"

(* 駅名の情報を格納するレコード型
type ekimei_t = {
  kanji   : string; (* 漢字の駅名 *)
  kana    : string; (* 読み *)
  romaji  : string; (* ローマ字 *)
  shozoku : string; (* 所属路線名 *)
}
*)

(* 目的：ローマ字と駅名のリストを受け取り、対応する感じ表記を文字列で返す *)
(* romaji_to_kanji : string -> ekimei_t list -> string*)
let rec romaji_to_kanji name lst = match (name, lst) with
    ("", []) -> ""
  | (name, []) -> ""
  | (name, {kanji = kj; kana = kn; romaji = r; shozoku = s}:: rest) ->
      if r = name then kj
      else romaji_to_kanji name rest

(* test *)
let test1 = romaji_to_kanji "" global_ekimei_list = ""
let test2 = romaji_to_kanji "yamahahatsudouki" global_ekimei_list = ""
let test3 = romaji_to_kanji "myogadani" global_ekimei_list = "茗荷谷"
let test4 = romaji_to_kanji "nishinippori" global_ekimei_list = "西日暮里"
let test5 = romaji_to_kanji "shibuya" global_ekimei_list = "渋谷"
