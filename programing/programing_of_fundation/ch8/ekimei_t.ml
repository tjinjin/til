(* 駅名の情報を格納するレコード（漢字、仮名、ローマ字、所属する路線名*)
type ekimei_t = {
  kanji   : string;
  kana    : string;
  romaji  : string;
  shozoku : string;
}
