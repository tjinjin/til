(* year_t/seiza型をインポートする *)
#use "ch17/seiza_t.ml"

(* year_t型を受け取り、星座を返す *)
(* seiza : year_t -> seiza_t *)
let seiza year = match year with
    January     (n) -> if n < 21 then Capricorus   else Aquarius
  |  February   (n) -> if n < 20 then Aquarius     else Pisces
  |  March      (n) -> if n < 21 then Pisces       else Aries
  |  April      (n) -> if n < 21 then Aries        else Taurus
  |  May        (n) -> if n < 21 then Taurus       else Gemini
  |  June       (n) -> if n < 22 then Gemini       else Cancer
  |  July       (n) -> if n < 24 then Cancer       else Leo
  |  August     (n) -> if n < 24 then Leo          else Virgo
  |  September  (n) -> if n < 24 then Virgo        else Libra
  |  October    (n) -> if n < 24 then Libra        else Scorpius
  |  November   (n) -> if n < 23 then Scorpius     else Sagittarius
  |  December   (n) -> if n < 23 then Sagittarius  else Capricorus

(* test *)
let test1 = seiza(January (13)) = Aquarius
let test1 = seiza (June (11)) = Gemini
let test2 = seiza (June (30)) = Cancer
let test3 = seiza (September (17)) = Virgo
let test4 = seiza (October (7)) = Libra
