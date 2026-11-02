-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: film --
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483648, '5k5swwqcgs', 'fil_014812', '9n8', 1610062532);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483647, 'pgu7vfe4', 'fil_014812', 'hria2ypuzhs', 700293388);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483646, 'wbbp6luhvdlt', 'fil_014812', 'ilbnp', 1236688122);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483645, 'dpos', 'fil_014812', 'ie5', -1209887326);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483644, 'klfa9000t', 'fil_014812', 'c4ecigce', -1585009206);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483643, '52zb', 'fil_014812', 'uo4nrqrofqy', -1106983592);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483642, '5bbp0', 'fil_014812', '2eutliqa11r', 2137741668);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483641, 'ytoo3o9hl7', 'fil_014812', 'klex14ji', -453362185);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483640, 'au2dwyrq13', 'fil_014812', 'yu78', 244829661);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483639, 'jsl', NULL, 'b4yp5qi', -227162283);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483638, 'f9v', NULL, 'x58pz', -1529584866);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483637, 'd2', NULL, 'vy9uxj4', -1612443122);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483636, 'd', 'fil_014812', 'lph2gn', 1968874827);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483635, 'nqcx5h', 'fil_014812', 'cprj', -841004020);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483634, 'dz79fjg', 'fil_014812', '8n2f3', 806170397);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT studio FROM (SELECT studio, COUNT(*) AS n FROM film GROUP BY studio) WHERE (n = 2) ORDER BY studio;

/*
Gold Result:
*/

-- Prediction Query
SELECT Studio FROM film GROUP BY Studio HAVING COUNT(*) >= 2;

/*
Prediction Result:
(None,)
('fil_014812',)
*/