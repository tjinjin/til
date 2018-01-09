(* 文字列のリストを受け取り、1文字にする*)
(* concat : string list -> string *)
let rec concat lst = match lst with
    [] -> ""
  | first :: rest -> first ^ concat rest


(* test *)
let test1 = concat [] = ""
let test2 = concat ["aaa"] = "aaa"
let test3 = concat ["aaa";"bbb";"ccc"] = "aaabbbccc"
