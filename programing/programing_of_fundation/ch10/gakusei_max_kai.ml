(* 学生一人分のデータ（名前、点数、成績）を表す型*)
type gakusei_t = {
  name: string;
  score: int;
  grade: string;
}

(* gakusei_t list は
 - []               空リスト, あるいは
 - first :: rest    最初の要素がfirstで残りのリストがrest
                    firstはgakusei_t型、restが自己参照のケース*)

(* gakusei_t list 型のデータの例 *)
let gakusei1 = {name="nakamura"; score=90; grade="A"}
let gakusei2 = {name="miyahara"; score=80; grade="A"}
let gakusei3 = {name="sato"; score=75; grade="B"}
let gakusei4 = {name="idehara"; score=70; grade="B"}
let gakusei5 = {name="tsubata"; score=65; grade="C"}
let gakusei6 = {name="asai"; score=60; grade="C"}
let dummy    = {name="aaa"; score=min_int; grade="Z"}

(* 学生のリストの例 *)
let lst1 = []
let lst2 = [gakusei2]
let lst3 = [gakusei3; gakusei4]
let lst4 = [gakusei4; gakusei3]
let lst5 = [gakusei4; gakusei1; gakusei6; gakusei5; gakusei2; gakusei3]

(* 目的：学生リストから最高点を取った人のレコードを返す *)
(* gakusei_max : gakusei_t list -> gakusei_t *)
let rec gakusei_max lst = match lst with
    [] -> dummy
  | ({name = n; score = s; grade = g} as gakusei) :: rest ->
      let max = gakusei_max rest in
      match max with
        {name = n_max; score = s_max; grade = g_max} ->
    if s_max < s then gakusei
    else max

(* test *)
let test1 = gakusei_max lst1 = dummy
let test2 = gakusei_max lst2 = gakusei2
let test3 = gakusei_max lst3 = gakusei3
let test4 = gakusei_max lst4 = gakusei3
let test5 = gakusei_max lst5 = gakusei1
