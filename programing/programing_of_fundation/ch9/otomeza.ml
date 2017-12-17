(* seiza関数を読み込む*)
#use "ch5/seiza.ml"


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
  - []            空リストあるいは
  - first :: rest 最初の要素がfirstで残りのリストがrest
                  (first はperson_t型
                   restが自己参照のケース) *)


(* person_t list型のデータ例*)
let lst1 = []
let lst2 = [{name = "中村";  shincho = 1.68;  taiju = 63.0;  tsuki = 6;  hi = 6;  ketsueki = "O"}]
let lst3 = [{name = "中村";  shincho = 1.68;  taiju = 63.0;  tsuki = 6;  hi = 6;  ketsueki = "O"};
            {name = "浅井";  shincho = 1.72;  taiju = 58.5;  tsuki = 9;  hi = 17; ketsueki = "A"}]
let lst4 = [{name = "浅井";  shincho = 1.72;  taiju = 58.5;  tsuki = 9;  hi = 17; ketsueki = "A"};
            {name = "宮原";  shincho = 1.63;  taiju = 55.0;  tsuki = 6;  hi = 30; ketsueki = "B"};
            {name = "中村";  shincho = 1.68;  taiju = 63.0;  tsuki = 6;  hi = 6;  ketsueki = "O"};
            {name = "田尾";  shincho = 1.87;  taiju = 75.0;  tsuki = 8;  hi = 30; ketsueki = "A"}]

(* 目的：人リストを受け取り、乙女座の人のリストを返す *)
(* otomeza : person_t list -> string list*)
let rec otomeza lst = match lst with
    [] -> []
  | {name = n; shincho = s; taiju = t; tsuki = bt; hi = bh; ketsueki = k} :: rest
      -> if seiza bt bh = "Virgo" then n :: otomeza rest(*otomeza rest*)
                                                          else otomeza rest

(*test*)
let test1 = otomeza lst1 = []
let test2 = otomeza lst2 = []
let test3 = otomeza lst3 = ["浅井"]
let test4 = otomeza lst4 = ["浅井"; "田尾"]
