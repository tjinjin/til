(* 学生一人分のデータ（名前、点数、成績)を表す型 *)
type gakusei_t = {
  name:   string;
  score:  int;
  result: string;
}

(* 目的：学生のデータ gakusei を受け取り成績のついたデータを返す *)
(* hyouka : gakusei_t -> gakusei_t *)
let hyouka gakusei = match gakusei with
  {name = n;score = s;result = r} ->
    {name = n;score = s;result=if s >= 80 then "A"
                               else if s >= 70 then "B"
                               else if s >= 60 then "C"
                               else "D"
  }

(* test *)
let test1 = hyouka {name="asai";score=90;result=""}={name="asai";score=90;result="A"}
let test2 = hyouka {name="asai";score=80;result=""}={name="asai";score=80;result="A"}
let test3 = hyouka {name="asai";score=75;result=""}={name="asai";score=75;result="B"}
let test4 = hyouka {name="asai";score=70;result=""}={name="asai";score=70;result="B"}
let test5 = hyouka {name="asai";score=65;result=""}={name="asai";score=65;result="C"}
let test6 = hyouka {name="asai";score=60;result=""}={name="asai";score=60;result="C"}
let test7 = hyouka {name="asai";score=55;result=""}={name="asai";score=55;result="D"}
