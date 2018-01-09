(* 目的：リスト中の文字列をつなげた文字列を返す*)
(* concat : string list -> string*)
let concat lst =
  (* 目的：文字列をくっつける *)
  (* concat_str: string -> string -> string*)
  let concat_str a b = a ^ b
  in fold_right concat_str lst ""

(* テスト *)
let test1 = concat [] = ""
let test2 = concat ["春"] = "春"
let test3 = concat ["春"; "夏"; "秋"; "冬"] = "春夏秋冬"
