library( data.table )
DT <- data.table::fread( "./data/day01-input.txt" )
data.table::CJ( DT$V1, DT$V1 )[, sum := V1 + V2][ sum == 2020, ]
# V1   V2  sum
# 1:   21 1999 2020
# 2: 1999   21 2020

1999 * 21
#[1] 41979

####################
# part 2
####################
DT <- data.table::fread( "./data/day01-input.txt" )
combos <- as.data.table( t( combn( DT$V1, 3, simplify = TRUE ) ) )
prod( combos[ rowSums( combos ) == 2020, ] )

#193416912