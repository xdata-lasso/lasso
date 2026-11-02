-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1005, 'Environmental health practitioner', 'since', 'blue', 1007);
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1006, 'Corporate treasurer', 'since', 'require', 1018.0);
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1009, NULL, 'performance', 'knowledge', 1011);
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1010, NULL, 'performance', 'almost', 1022.0);
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1013, 'Air traffic controller', 'performance', 'discover', 1015);
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1014, 'Chief Financial Officer', 'performance', 'early', 1026.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT studio FROM (SELECT studio, COUNT(*) AS n FROM film GROUP BY studio) WHERE (n = 2) ORDER BY studio;

/*
Gold Result:
('since',)
*/

-- Prediction Query
SELECT Studio FROM film GROUP BY Studio HAVING COUNT(*) >= 2;

/*
Prediction Result:
('performance',)
('since',)
*/