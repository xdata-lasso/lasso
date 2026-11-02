-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1, '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe', 'hria2ypu');

-- Inserting into table: body_builder --
INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (1, 1, 1.0, 1.0, 1.0);

INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (-2147483647, 1, 1.0, 1.0, 1.0);

INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (-1, 1, 7719.0, 294.861575, 268.234631);

INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (0, 1, 0.0, 944.247544, 994.117864);

INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (-2147483644, 1, 503.083789, 1.0, 320.851235);

INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (-2147483643, 1, 334.878198, 1.0, 55.194297);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT clean_jerk FROM (SELECT * FROM (SELECT * FROM body_builder ORDER BY snatch DESC, body_builder.body_builder_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(294.861575,)
*/

-- Prediction Query
SELECT Clean_Jerk FROM body_builder ORDER BY Total DESC, body_builder.body_builder_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(944.247544,)
*/