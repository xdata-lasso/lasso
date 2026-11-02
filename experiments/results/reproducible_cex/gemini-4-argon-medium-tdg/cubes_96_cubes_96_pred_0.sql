-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('1', 'S1', 'USA', 'English', 'News', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('2', 'S2', 'UK', 'English', 'Sports', '16:9', 'Yes', 'Yes', 'Premium');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('3', 'S3', 'Canada', 'English', 'Music', '4:3', 'No', 'No', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('4', 'S4', 'France', 'French', 'News', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('5', 'S5', 'France', 'French', 'Movies', '16:9', 'Yes', 'Yes', 'Premium');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('6', 'S6', 'Spain', 'Spanish', 'Drama', '4:3', 'No', 'No', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('7', 'S7', 'Germany', 'German', 'Documentary', '16:9', 'Yes', 'No', 'Basic');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT language_other AS LANGUAGE, n_other AS count___ FROM (SELECT LHS.language AS LANGUAGE, LHS.n AS n, RHS.language AS language_other, RHS.n AS n_other FROM (SELECT LANGUAGE, COUNT(*) AS n FROM tv_channel GROUP BY LANGUAGE) AS LHS CROSS JOIN (SELECT LANGUAGE, COUNT(*) AS n FROM tv_channel GROUP BY LANGUAGE) AS RHS) WHERE (n > n_other) ORDER BY LANGUAGE, count___ NULLS LAST;

/*
Gold Result:
('French', 2)
('German', 1)
('German', 1)
('Spanish', 1)
('Spanish', 1)
*/

-- Prediction Query
SELECT LANGUAGE, COUNT(*) FROM TV_Channel GROUP BY LANGUAGE ORDER BY COUNT(*) ASC, LANGUAGE NULLS LAST LIMIT 1;

/*
Prediction Result:
('German', 1)
*/