## data frame
vectors <- list(c(1, 2, 3), c(4, 5, 6), c(7, 8, 9))

## do.call() - execute a function call
combined_matrix <- do.call(rbind, vectors)
combined_matrix

combined_data_frame <- as.data.frame(combined_matrix)
combined_data_frame

## find first non-missing element
coalesce(combined_data_frame)

## conditional check
any(combined_data_frame > 8)
any(is.na(combined_data_frame))

## count # of characters - true/false
nzchar("")
nzchar(vectors)

