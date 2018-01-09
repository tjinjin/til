(* 文字列につける数字 *)
let counter = ref (-1)

(* 目的：文字列に毎回、異なる数字をつけて返す *)
(* gensym : string -> string *)
let gensym str =
  (counter := !counter + 1;
   str ^ string_of_int !counter)

(* テスト *)
let test1 = gensym "a" = "a0"
let test2 = gensym "a" = "a1"
let test3 = gensym "x" = "x2"
