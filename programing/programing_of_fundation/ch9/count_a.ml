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
let lst1 = []
let lst2 = [{name = "asai"; score = 70; grade = "B"}]
let lst3 = [{name = "asai"; score = 70; grade = "B"};
            {name = "kaneko"; score = 85; grade = "A"}]
let lst4 = [{name = "yoshida"; score = 80; grade = "A"};
            {name = "asai"; score = 70; grade = "B"};
            {name = "kaneko"; score = 85; grade = "A"}]

(* 目的：学生リストlstのうち成績がAの人の数を返す*)
(*count_A : gakusei_t list -> int*)
let rec count_A lst = match lst with
    [] -> 0
  | first :: rest  -> (match first with
                        {name = n; score = s; grade = g}
                          -> if g = "A" then 1 + count_A rest (* count_A rest *)
                                        else count_A rest)(* count_A rest *)

(*test*)
let test1 = count_A lst1 = 0
let test2 = count_A lst2 = 0
let test3 = count_A lst3 = 1
let test4 = count_A lst4 = 2
