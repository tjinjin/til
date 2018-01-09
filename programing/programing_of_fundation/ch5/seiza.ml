(* purpose: 誕生日を受取、星座を変えす*)
(* seiza : int -> int -> string *)
(* 雑にやったので、存在しない日付に対する考慮をしてない。サポートページだとごりごり書いてた*)
let seiza x y =
  if x = 3 then
      if y >= 21 then "Aries" else "Pisces"
    else if x = 4 then
      if y >= 20 then "Taurus" else "Aries"
    else if x = 5 then
      if y >= 21 then "Gemini" else "Taurus"
    else if x = 6 then
      if y >= 22 then "Cancer" else "Gemini"
    else if x = 7 then
      if y >= 23 then "Leo" else "Cancer"
    else if x = 8 then
      if y >= 23 then "Virgo" else "Leo"
    else if x = 9 then
      if y >= 23 then "Libra" else "Virgo"
    else if x = 10 then
      if y >= 24 then "Scorpio" else "Libra"
    else if x = 11 then
      if y >= 23 then "Sagittarius" else "Scorpio"
    else if x = 12 then
      if y >= 22 then "Capricorn" else "Sagittarius"
    else if x = 1 then
      if y >= 20 then "Aquarius" else "Capricorn"
    else if x = 2 then
      if y >= 19 then "Pisces" else "Aquarius"
    else "nothing"


(* test *)
let test1  = seiza 3 21  = "Aries"
let test2  = seiza 4 19  = "Aries"
let test3  = seiza 4 20  = "Taurus"
let test4  = seiza 5 20  = "Taurus"
let test5  = seiza 5 21  = "Gemini"
let test6  = seiza 6 21  = "Gemini"
let test7  = seiza 6 22  = "Cancer"
let test8  = seiza 7 22  = "Cancer"
let test9  = seiza 7 23  = "Leo"
let test10 = seiza 8 22  = "Leo"
let test11 = seiza 8 23  = "Virgo"
let test12 = seiza 9 22  = "Virgo"
let test13 = seiza 9 23  = "Libra"
let test14 = seiza 10 23 = "Libra"
let test15 = seiza 10 24 = "Scorpio"
let test16 = seiza 11 22 = "Scorpio"
let test17 = seiza 11 23 = "Sagittarius"
let test18 = seiza 12 21 = "Sagittarius"
let test19 = seiza 12 22 = "Capricorn"
let test20 = seiza 1 19  = "Capricorn"
let test21 = seiza 1 20  = "Aquarius"
let test22 = seiza 2 18  = "Aquarius"
let test23 = seiza 2 19  = "Pisces"
let test24 = seiza 3 20  = "Pisces"

