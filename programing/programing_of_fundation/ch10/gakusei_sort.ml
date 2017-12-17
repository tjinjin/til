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

(* 学生のリストの例 *)
let lst1 = []
let lst2 = [gakusei2]
let lst3 = [gakusei3; gakusei4]
let lst4 = [gakusei4; gakusei3]
let lst5 = [gakusei4; gakusei1; gakusei6; gakusei5; gakusei2; gakusei3]

(*目的：学生型のデータ挿入する*)
(* gakusei_insert : gakusei_t list -> gakusei_t -> gakusei_t list*)
let rec gakusei_insert lst gakusei0 = match lst with
    [] -> [gakusei0]
  | ({name = n; score = s; grade = g } as gakusei) :: rest ->
      match gakusei0 with {name = n0; score = s0; grade = g0} ->
  if s < s0 then gakusei :: gakusei_insert rest gakusei0
  else gakusei0 :: lst

(*目的：学生リストを受け取り点数順でソートする*)
(*gakusei_ins_sort: gakusei_t list -> gakusei_t list*)
let rec gakusei_ins_sort lst = match lst with
    [] -> []
  | first :: rest -> gakusei_insert (gakusei_ins_sort rest) first


let test5 = gakusei_ins_sort lst1 = []
let test6 = gakusei_ins_sort lst2 = [gakusei2]
let test7 = gakusei_ins_sort lst3 = [gakusei4; gakusei3]
let test8 = gakusei_ins_sort lst4 = [gakusei4; gakusei3]
let test9 = gakusei_ins_sort lst5
	    = [gakusei6; gakusei5; gakusei4; gakusei3; gakusei2; gakusei1]


