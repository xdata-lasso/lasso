-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1101, 'Stacey Ward', 1104.5, 1107.5, 'trial', 'fall');
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1102, 'Benjamin Stanley', 1111.5, 1116.5, 'blood', 'long');
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1103, 'Victoria Wyatt', 1118.5, 1125.5, 'husband', 'prove');
INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (1110, 1101, 1113.5, 1116.5, NULL);
INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (1111, 1101, 1120.5, 1125.5, NULL);
INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (1112, 1101, 1127.5, 1134.5, NULL);
INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (1122, 1101, 1125.5, 1128.5, NULL);
INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (1123, 1101, 1132.5, 1137.5, NULL);
INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (1124, 1101, 1139.5, 1146.5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT clean_jerk FROM (SELECT LHS.body_builder_id AS body_builder_id, LHS.people_id AS people_id, LHS.snatch AS snatch, LHS.clean_jerk AS clean_jerk, LHS.total AS total, LHS.maxtotal AS maxtotal, RHS.body_builder_id AS body_builder_id_other, RHS.people_id AS people_id_other, RHS.snatch AS snatch_other, RHS.clean_jerk AS clean_jerk_other, RHS.total AS total_other, RHS.maxtotal AS maxtotal_other FROM (SELECT body_builder_id, people_id, snatch, clean_jerk, total, MAX(total) OVER () AS maxtotal FROM body_builder) AS LHS CROSS JOIN (SELECT body_builder_id, people_id, snatch, clean_jerk, total, MAX(total) OVER () AS maxtotal FROM body_builder) AS RHS) WHERE (total >= maxtotal_other OR maxtotal < total_other) ORDER BY clean_jerk;

/*
Gold Result:
*/

-- Prediction Query
SELECT Clean_Jerk FROM body_builder ORDER BY Total DESC, body_builder.body_builder_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1116.5,)
*/