(* 駅と駅の接続情報を表す 起点の駅名、終点の駅名、経由する路線名、２駅間の距離、その所要時間*)
type ekikan_t = {
  kiten   : string;
  shuten  : string;
  keiyu   : string;
  kyori   : float;
  jikan   : int;
}
