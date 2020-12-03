library( data.table )

###################
# PART 1
###################
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

###################
# PART 2
###################
DT <- fread( "./data/day03_input.txt", header = FALSE )
#repeat string 100 times
DT[, long := strrep( V1, 100 ) ]
#function
ans <- mapply( function(x, y) {
  #create temprary copy of DT
  temp <- copy(DT)
  #select relevant rows based on y-step
  temp <- temp[ seq(1, nrow(temp), y), ]
  #get rownumeber
  temp[, rowpos := .I ]
  #get position in rownumber
  temp[, colpos := 1 + (rowpos - 1) * x ]
  #build regex
  temp[, regex := paste0( "^.{", colpos - 1, "}#" ) ]
  #get if tree (TRUE/FALSE)
  temp[, tree := unlist( Map( grepl, regex, long, perl = TRUE ) ) ]
  #answer
  sum(temp$tree)
}, c(1,3,5,7,1), c(1,1,1,1,2) )
#[1]  60 286  76  62  45
prod(ans)
# [1] 3638606400