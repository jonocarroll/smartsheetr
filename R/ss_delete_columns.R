#' Delete non-primary columns from a given sheet.
#'
#' The primary column(s) cannot be deleted.
#'
#' @param ss_id The sheetId (or permalink) of the table to read
#' @param column_ids A vector of the smartsheet rowIds, or NULL to delete all non-primary columns
#'
#' @return A list of ss_resp objects
#'
#' @export
ss_delete_columns <- function(ss_id, column_ids = NULL) {
  ss_id = validate_ss_id(ss_id)
  if(is.null(column_ids)) {
    resp_sheet = ss_get(path = paste0('sheets/',ss_id))
    columns_data = ss_resp_data_to_dataframe(resp_sheet$content$columns)
    column_ids = columns_data[!columns_data$primary | is.na(columns_data$primary),"id"]
  }
  purrr::map(column_ids, ~ss_delete(path=paste0('sheets/',ss_id,'/columns/',.x)))
}
