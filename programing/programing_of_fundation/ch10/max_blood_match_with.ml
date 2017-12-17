(*人の個人データ（名前、身長、体重、誕生月、誕生日、血液型) を表す型*)
type person_t = {
  name : string;	(* 名前 *)
  tall : float;	(* 身長 *)
  weight: float;	(* 体重 *)
  month : int;		(* 誕生月 *)
  day : int;		(* 誕生日 *)
  blood : string;	(* 血液型 *)
}

(* person_t list型のデータ例*)
let lst1 = []
let lst2 = [{name = "中村";  tall = 1.68;  weight = 63.0;  month = 6;  day = 6;  blood = "O"}]
let lst3 = [{name = "中村";  tall = 1.68;  weight = 63.0;  month = 6;  day = 6;  blood = "O"};
            {name = "浅井";  tall = 1.72;  weight = 58.5;  month = 9;  day = 17; blood = "A"}]
let lst4 = [{name = "浅井";  tall = 1.72;  weight = 58.5;  month = 9;  day = 17; blood = "A"};
            {name = "宮原";  tall = 1.63;  weight = 55.0;  month = 6;  day = 30; blood = "B"};
            {name = "中村";  tall = 1.68;  weight = 63.0;  month = 6;  day = 6;  blood = "O"};
            {name = "田尾";  tall = 1.87;  weight = 75.0;  month = 8;  day = 30; blood = "A"}]
let lst5 = [{name = "浅井";  tall = 1.72;  weight = 58.5;  month = 9;  day = 17; blood = "A"};
            {name = "宮原";  tall = 1.63;  weight = 55.0;  month = 6;  day = 30; blood = "B"};
            {name = "中村";  tall = 1.68;  weight = 63.0;  month = 6;  day = 6;  blood = "O"};
            {name = "井上";  tall = 1.73;  weight = 73.0;  month = 10; day = 30; blood = "AB"};
            {name = "田尾";  tall = 1.87;  weight = 75.0;  month = 8;  day = 30; blood = "A"}]

(* 目的：人リストを受け取って各血液型が何人いるか返す *)
(* sum_blood : person_t list -> int * int * int * int *)
let rec sum_blood lst = match lst with
    [] -> (0, 0, 0, 0)
  | {name = n; tall = t; weight = w; month = m; day = d; blood = b} :: rest ->
      let (a, bb, o, ab) = sum_blood rest in
      if b = "A" then (a + 1, bb, o, ab)
      else if b = "B" then (a, bb + 1, o, ab)
      else if b = "O" then (a, bb, o + 1, ab)
      else (a, bb, o, ab + 1)

(* test *)
let test1 = sum_blood lst1 = (0, 0, 0, 0)
let test2 = sum_blood lst2 = (0, 0, 1, 0)
let test3 = sum_blood lst3 = (1, 0, 1, 0)
let test4 = sum_blood lst4 = (2, 1, 1, 0)

(* 目的：血液型の組から一番人数が多い血液型を抽出する *)
(* max_blood : person_t list -> string*)
let max_blood lst =
  let (a, bb, o, ab) = sum_blood lst in
  match (a, bb, o, ab) with
  (a, bb, o, ab) ->
    let saidai = max (max a o) (max bb ab) in
    match saidai with
     saidai -> if saidai = a then "A"
               else if saidai = o then "O"
               else if saidai = bb then "B"
               else "AB"

(*test*)
let test1 = max_blood lst1 = "A"
let test2 = max_blood lst2 = "O"
let test3 = max_blood lst3 = "A"
let test4 = max_blood lst4 = "A"
