(* 問題 14.1 *)

(* 目的：受け取ったリストの中から偶数のみを抜き出したリストを返す *)
(* even : int list -> int *)
let even lst =
  (* 目的：受け取った整数が偶数かどうかを判定する *)
  (* is_even : int -> bool *)
  let is_even n = n mod 2 = 0
  in List.filter is_even lst

(* テスト *)
let test1 = even [] = []
let test2 = even [3] = []
let test3 = even [2] = [2]
let test4 = even [2; 1; 6; 4; 7] = [2; 6; 4]
let test5 = even [1; 2; 6; 4; 7] = [2; 6; 4]

(* 問題 14.2 *)

(* 学生ひとり分のデータ（名前、点数、成績）を表す型 *)
type gakusei_t = {
  namae : string;       (* 名前 *)
  tensuu : int;         (* 点数 *)
  seiseki : string;     (* 成績 *)
}

(* gakusei_t list 型のデータの例 *)
let lst1 = []
let lst2 = [{namae = "asai"; tensuu = 70; seiseki = "B"}]
let lst3 = [{namae = "asai"; tensuu = 70; seiseki = "B"};
            {namae = "kaneko"; tensuu = 85; seiseki = "A"}]
let lst4 = [{namae = "yoshida"; tensuu = 80; seiseki = "A"};
            {namae = "asai"; tensuu = 70; seiseki = "B"};
            {namae = "kaneko"; tensuu = 85; seiseki = "A"}]

(* 目的：学生リスト lst のうち成績が A の人の数を返す *)
(* count_A : gakusei_t list -> int *)
let count_A lst =
  (* 目的：学生の成績が A かどうかを調べる *)
  (* is_A : gakusei_t -> bool *)
  let is_A gakusei = match gakusei with
    {namae = n; tensuu = t; seiseki = s} -> s = "A"
  in List.length (List.filter is_A lst)

(* テスト *)
let test1 = count_A lst1 = 0
let test2 = count_A lst2 = 0
let test3 = count_A lst3 = 1
let test4 = count_A lst4 = 2

(* 問題 14.3 *)

(* 目的：リスト中の文字列をつなげた文字列を返す *)
(* concat : string list -> string *)
let concat lst =
  (* 目的：ふたつの文字列をつなげる *)
  (* append_string : string -> string -> string *)
  let append_string first rest_result = first ^ rest_result
  in List.fold_right append_string lst ""

(* テスト *)
let test1 = concat [] = ""
let test2 = concat ["春"] = "春"
let test3 = concat ["春"; "夏"; "秋"; "冬"] = "春夏秋冬"

(* 問題 14.4 *)

(* 学生ひとり分のデータ（名前、点数、成績）を表す型 *)
type gakusei_t = {
  namae : string;       (* 名前 *)
  tensuu : int;         (* 点数 *)
  seiseki : string;     (* 成績 *)
}

(* gakusei_t list 型のデータの例 *)
let lst1 = []
let lst2 = [{namae = "asai"; tensuu = 70; seiseki = "B"}]
let lst3 = [{namae = "asai"; tensuu = 70; seiseki = "B"};
            {namae = "kaneko"; tensuu = 85; seiseki = "A"}]
let lst4 = [{namae = "yoshida"; tensuu = 80; seiseki = "A"};
            {namae = "asai"; tensuu = 70; seiseki = "B"};
            {namae = "kaneko"; tensuu = 85; seiseki = "A"}]

(* 目的：受け取った学生リスト lst の得点の合計を返す *)
(* gakusei_sum : gakusei_t list -> int *)
let gakusei_sum lst =
  (* 目的：受け取った学生リスト lst の得点の合計を返す *)
  (* add_tokuten : gakusei_t -> int -> int *)
  let add_tokuten gakusei rest_result = match gakusei with
    {namae = n; tensuu = t; seiseki = s} -> t + rest_result
  in List.fold_right add_tokuten lst 0

(* テスト *)
let test1 = gakusei_sum lst1 = 0
let test2 = gakusei_sum lst2 = 70
let test3 = gakusei_sum lst3 = 155
let test4 = gakusei_sum lst4 = 235
