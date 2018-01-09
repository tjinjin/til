(*人の個人データ（名前、身長、体重、誕生月、誕生日、血液型) を表す型*)
type person_t = {
  name : string;	(* 名前 *)
  shincho : float;	(* 身長 *)
  taiju : float;	(* 体重 *)
  tsuki : int;		(* 誕生月 *)
  hi : int;		(* 誕生日 *)
  ketsueki : string;	(* 血液型 *)
}

(* person_t listは
 - []            空リスト、あるいは
 - first :: rest 最初の要素がfirstで残りのリストがrest
                 (firstはperson_t型、
                  restが自己参照のケース)*)

(* person_t list型のデータ例*)
let lst1 = []
let lst2 = [{name = "中村";  shincho = 1.68;  taiju = 63.0;  tsuki = 6;  hi = 6;  ketsueki = "O"}]
let lst3 = [{name = "中村";  shincho = 1.68;  taiju = 63.0;  tsuki = 6;  hi = 6;  ketsueki = "O"};
            {name = "浅井";  shincho = 1.72;  taiju = 58.5;  tsuki = 9;  hi = 17; ketsueki = "A"}]
let lst4 = [{name = "浅井";  shincho = 1.72;  taiju = 58.5;  tsuki = 9;  hi = 17; ketsueki = "A"};
            {name = "宮原";  shincho = 1.63;  taiju = 55.0;  tsuki = 6;  hi = 30; ketsueki = "B"};
            {name = "中村";  shincho = 1.68;  taiju = 63.0;  tsuki = 6;  hi = 6;  ketsueki = "O"};
            {name = "田尾";  shincho = 1.87;  taiju = 75.0;  tsuki = 1;  hi = 30; ketsueki = "A"}]

(* 目的：人リスト lst のうち血液型がAの人の数を返す *)
(* count_ketsueki_A : person_t list -> int *)
let rec count_ketsueki_A lst = match lst with
    [] -> 0
  | {name = n; shincho = s; taiju = t; tsuki = bt; hi = bh; ketsueki = k} :: rest
      -> if k = "A" then 1 + count_ketsueki_A rest (* count_ketsueki_A rest*)
                           else count_ketsueki_A rest

(*test*)
let test1 = count_ketsueki_A lst1 = 0
let test2 = count_ketsueki_A lst2 = 0
let test3 = count_ketsueki_A lst3 = 1
let test4 = count_ketsueki_A lst4 = 2
