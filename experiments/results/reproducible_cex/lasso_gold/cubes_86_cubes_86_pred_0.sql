-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('purpose', 'Noah Rhodes', 'Qatar', 'source', 'her', 'animal', 'human', 'present', 'sea');
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('brother', 'Angie Henderson', 'Jamaica', 'great', 'throw', 'show', 'bar', 'value', 'available');
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('ago', 'Daniel Wagner', 'Guam', 'blue', 'guy', 'machine', 'old', 'training', 'answer');
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('site', 'Cristian Santos', 'Fiji', 'best', 'PM', 'not', 'finally', 'high', 'recently');
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('face', 'Connie Lawrence', 'Cape Verde', 'husband', 'everything', 'capital', 'themselves', 'participant', 'drive');
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('election', 'Abigail Shaffer', 'Cuba', 'bill', 'surface', 'win', 'production', 'dark', 'spring');
INSERT INTO "tv_series" ("id", "channel", "episode", "air_date", "rating", "share", "18_49_rating_share", "viewers_m", "weekly_rank") VALUES (1001.5, 'purpose', 'figure', 'fall', 'hospital', 1007.5, 'write', 'none', 1013.5);
INSERT INTO "tv_series" ("id", "channel", "episode", "air_date", "rating", "share", "18_49_rating_share", "viewers_m", "weekly_rank") VALUES (1002.5, 'purpose', 'base', 'long', 'hear', 1020.5, 'result', 'shoulder', 1032.5);
INSERT INTO "tv_series" ("id", "channel", "episode", "air_date", "rating", "share", "18_49_rating_share", "viewers_m", "weekly_rank") VALUES (1003.5, 'purpose', 'top', 'prove', 'determine', 1033.5, 'raise', 'common', 1051.5);
INSERT INTO "tv_series" ("id", "channel", "episode", "air_date", "rating", "share", "18_49_rating_share", "viewers_m", "weekly_rank") VALUES (1004.5, 'purpose', 'early', 'they', 'religious', 1046.5, 'away', 'maintain', 1070.5);
INSERT INTO "tv_series" ("id", "channel", "episode", "air_date", "rating", "share", "18_49_rating_share", "viewers_m", "weekly_rank") VALUES (1005.5, 'purpose', 'trial', 'his', 'example', 1059.5, 'politics', 'hundred', 1089.5);
INSERT INTO "tv_series" ("id", "channel", "episode", "air_date", "rating", "share", "18_49_rating_share", "viewers_m", "weekly_rank") VALUES (1006.5, 'purpose', 'blood', 'commercial', 'science', 1072.5, 'Congress', 'expect', 1108.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT episode, rating FROM (SELECT * FROM (SELECT * FROM tv_series ORDER BY SHARE DESC, tv_series.id NULLS LAST) LIMIT 3);

/*
Gold Result:
('blood', 'science')
('trial', 'example')
('early', 'religious')
*/

-- Prediction Query
SELECT Episode, Rating FROM TV_series ORDER BY Rating DESC, TV_series.id NULLS LAST LIMIT 3;

/*
Prediction Result:
('blood', 'science')
('early', 'religious')
('figure', 'hospital')
*/