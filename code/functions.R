# functions to convert temperatures

F_to_K <- function(temp){
  K <- ((temp - 32) * (5/9)) + 273.15
  return(K)
}

F_to_K(32)
F_to_K(212)


K_to_C <- function(K){
  C <- ((K - 273.15))
  return(C)
}