library( data.table )

###########################
# PART 1
###########################
#read source
DT <- data.table::fread( "./data/day02_input.txt", header = FALSE, sep = " " )
#columns
DT[, c("min", "max") := lapply( tstrsplit( DT$V1, "-" ), as.numeric ) ]
DT[, character := gsub( ":", "", V2 ) ]
DT[, password := V3 ]
#count occurences of character
DT[, count := stringr::str_count( password, character )]
#nuber between min and max? (TRUE/FALSE)
DT[, correct := count >= min & count <= max ]
#answer
sum(DT$correct)
# [1] 548

###########################
# PART 2
###########################
DT <- data.table::fread( "./data/day02_input.txt", header = FALSE, sep = " " )
#columns
DT[, c("first", "second") := lapply( tstrsplit( DT$V1, "-" ), as.numeric ) ]
DT[, character := gsub( ":", "", V2 ) ]
DT[, password := V3 ]
#regexes
DT[, regex1 := paste0( "^.{", first - 1, "}", character ) ]
DT[, regex2 := paste0( "^.{", second - 1, "}", character ) ]
#perform regex by row
DT[, check1 := unlist( Map( grepl, regex1, password ) ) ]
DT[, check2 := unlist( Map( grepl, regex2, password ) ) ]
#answer
nrow( DT[ check1 + check2 == 1, ] )
#[1] 502
