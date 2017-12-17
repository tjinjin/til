(* 個人情報（名前、血液型) *)
type person_t = {
  name : string;
  blood: string;
}

(* データの例 *)
let person1 = {name="adachi"; blood="O"}
let person2 = {name="suzuki"; blood="AB"}
let person3 = {name="tabata"; blood="B"}
let person4 = {name="yamada"; blood="A"}

let lst1 = []
let lst2 = [person1]
let lst3 = [person2; person1]
let lst4 = [person3; person4; person2; person1]


(* 辞書順でソート済みのperson_tのリストに新しくperson_tを挿入する*)
(* person_insert : person_t list -> perston_t -> person_t list*)
let rec person_insert lst person0 = match lst with
    [] -> [person0]
  | ({name = n; blood = b} as person) :: rest ->
      match person0 with {name = n0; blood = b0} ->
  if n < n0 then person :: person_insert rest person0
  else person0 :: lst

(*test*)
let test5 = person_insert [] person1 = [person1]
let test6 = person_insert [person2] person1 = [person1; person2]
let test7 = person_insert [person2; person4] person3 = [person2; person3; person4]
let test8 = person_insert [person1; person2; person3] person4 = [person1; person2; person3; person4]

(*目的:person_t型のリストを辞書順で並べ替える*)
(* person_ins_sort : person_t list -> person_t list*)
let rec person_ins_sort lst = match lst with
    [] -> []
  | first :: rest -> person_insert (person_ins_sort rest) first


(*test*)
let test1 = person_ins_sort lst1 = []
let test2 = person_ins_sort [person2] = [person2]
let test3 = person_ins_sort lst3 = [person1; person2]
let test4 = person_ins_sort lst4 = [person1; person2; person3; person4]

