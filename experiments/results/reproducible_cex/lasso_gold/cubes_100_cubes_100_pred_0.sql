-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('table', 'Olivia Moore', 'Jamaica', 'grow', 'fall', 'clearly', 'dinner', 'source', 'great');
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('her', 'Lindsey Roman', 'Saint Lucia', 'machine', 'not', 'capital', 'win', 'human', 'bar');
INSERT INTO "cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (1006.5, 'table', 'Water engineer', 'best', 'husband', 'bill', 1007.5);
INSERT INTO "cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (1008.5, 'her', 'Civil engineer, consulting', 'finally', 'themselves', 'production', 1008.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, directed_by FROM cartoon ORDER BY title, cartoon.id NULLS LAST;

/*
Gold Result:
('Civil engineer, consulting', 'finally')
('Water engineer', 'best')
*/

-- Prediction Query
SELECT title, Directed_by FROM Cartoon ORDER BY Original_air_date, Cartoon.id NULLS LAST;

/*
Prediction Result:
('Water engineer', 'best')
('Civil engineer, consulting', 'finally')
*/