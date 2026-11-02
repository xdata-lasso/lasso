-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO TV_Channel (id, Language) VALUES ('1', 'English');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT language_other AS LANGUAGE, n_other AS count___ FROM (SELECT LHS.language AS LANGUAGE, LHS.n AS n, RHS.language AS language_other, RHS.n AS n_other FROM (SELECT LANGUAGE, COUNT(*) AS n FROM tv_channel GROUP BY LANGUAGE) AS LHS CROSS JOIN (SELECT LANGUAGE, COUNT(*) AS n FROM tv_channel GROUP BY LANGUAGE) AS RHS) WHERE (n > n_other) ORDER BY LANGUAGE, count___ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT LANGUAGE, COUNT(*) FROM TV_Channel GROUP BY LANGUAGE ORDER BY COUNT(*) ASC, LANGUAGE NULLS LAST LIMIT 1;

/*
Prediction Result:
('English', 1)
*/