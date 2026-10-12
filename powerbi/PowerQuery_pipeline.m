// Power Query (M) of the NYC Airbnb dashboard: the two cleaned tables of data/processed/
// DataFolder is a text parameter that holds the path of the data/processed/ folder.

// ---- Listings
let
    Folder = let p = Text.Trim(DataFolder, {"""", " "}) in if Text.EndsWith(p, "\") or Text.EndsWith(p, "/") then p else p & "\",
    Source = Csv.Document(File.Contents(Folder & "airbnb_nyc_clean.csv"), [Delimiter = ",", Columns = 29, Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    #"Blank As Null" = Table.TransformColumns(#"Promoted Headers", {{"id", each if _ = "" then null else _}, {"host_id", each if _ = "" then null else _}, {"price", each if _ = "" then null else _}, {"minimum_nights", each if _ = "" then null else _}, {"number_of_reviews", each if _ = "" then null else _}, {"calculated_host_listings_count", each if _ = "" then null else _}, {"availability_365", each if _ = "" then null else _}, {"price_band_order", each if _ = "" then null else _}, {"min_stay_order", each if _ = "" then null else _}, {"availability_band_order", each if _ = "" then null else _}, {"host_size_order", each if _ = "" then null else _}, {"last_review_year", each if _ = "" then null else _}, {"days_since_review", each if _ = "" then null else _}, {"borough_order", each if _ = "" then null else _}, {"room_order", each if _ = "" then null else _}, {"latitude", each if _ = "" then null else _}, {"longitude", each if _ = "" then null else _}, {"reviews_per_month", each if _ = "" then null else _}, {"last_review", each if _ = "" then null else _}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Blank As Null", {{"id", Int64.Type}, {"name", type text}, {"host_id", Int64.Type}, {"neighbourhood_group", type text}, {"neighbourhood", type text}, {"latitude", type number}, {"longitude", type number}, {"room_type", type text}, {"price", Int64.Type}, {"minimum_nights", Int64.Type}, {"number_of_reviews", Int64.Type}, {"last_review", type date}, {"reviews_per_month", type number}, {"calculated_host_listings_count", Int64.Type}, {"availability_365", Int64.Type}, {"has_reviews", type text}, {"price_band", type text}, {"price_band_order", Int64.Type}, {"min_stay", type text}, {"min_stay_order", Int64.Type}, {"availability_band", type text}, {"availability_band_order", Int64.Type}, {"host_size", type text}, {"host_size_order", Int64.Type}, {"last_review_year", Int64.Type}, {"days_since_review", Int64.Type}, {"active_12m", type text}, {"borough_order", Int64.Type}, {"room_order", Int64.Type}}, "en-US"),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type", {{"id", "Listing ID"}, {"name", "Listing Name"}, {"host_id", "Host ID"}, {"neighbourhood_group", "Borough"}, {"neighbourhood", "Neighbourhood"}, {"latitude", "Latitude"}, {"longitude", "Longitude"}, {"room_type", "Room Type"}, {"price", "Price"}, {"minimum_nights", "Minimum Nights"}, {"number_of_reviews", "Number of Reviews"}, {"last_review", "Last Review"}, {"reviews_per_month", "Reviews per Month"}, {"calculated_host_listings_count", "Host Listings"}, {"availability_365", "Availability 365"}, {"has_reviews", "Has Reviews"}, {"price_band", "Price Band"}, {"price_band_order", "Price Band Order"}, {"min_stay", "Minimum Stay"}, {"min_stay_order", "Minimum Stay Order"}, {"availability_band", "Availability Band"}, {"availability_band_order", "Availability Band Order"}, {"host_size", "Host Size"}, {"host_size_order", "Host Size Order"}, {"last_review_year", "Last Review Year"}, {"days_since_review", "Days Since Review"}, {"active_12m", "Active 12m"}, {"borough_order", "Borough Order"}, {"room_order", "Room Order"}})
in
    #"Renamed Columns"

// ---- Cleaning Log
let
    Folder = let p = Text.Trim(DataFolder, {"""", " "}) in if Text.EndsWith(p, "\") or Text.EndsWith(p, "/") then p else p & "\",
    Source = Csv.Document(File.Contents(Folder & "cleaning_log.csv"), [Delimiter = ",", Columns = 6, Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers", {{"Step", Int64.Type}, {"Name", type text}, {"Action", type text}, {"Rows Affected", Int64.Type}, {"Rows After", Int64.Type}, {"Median Price After", type number}}, "en-US")
in
    #"Changed Type"
