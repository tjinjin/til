(* 目的：受け取ったチーム名を文字列で返す *)
(* team_string : team_t -> string *)
let team_string team = match team with
  Red -> "紅組"
  | White -> "白組"

(*test*)
let test1 = team_string Red = "紅組"
let test2 = team_string White = "白組"
