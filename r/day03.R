library( data.table )

DT <- fread( "./data/day03_input.txt", header = FALSE )
#repeat string 100 times
DT[, long := strrep( V1, 100 ) ]
#get horizontal sn vertical position
DT[, rowpos := .I ]
DT[, colpos := 1 + (rowpos - 1) * 3 ]
#build regex
DT[, regex := paste0( "^.{", colpos - 1, "}#" ) ]
#get if tree
DT[, tree := unlist( Map( grepl, regex, long, perl = TRUE ) ) ]
#answer
sum(DT$tree)
#[1] 286