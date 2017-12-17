let compose f g =
  let z x = f (g x)
  in z;;
