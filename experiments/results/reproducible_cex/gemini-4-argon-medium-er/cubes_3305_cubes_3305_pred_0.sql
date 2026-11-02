-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Name") VALUES (1, 'Person 1');
INSERT INTO "people" ("People_ID", "Name") VALUES (2, 'Person 2');
INSERT INTO "body_builder" ("Body_Builder_ID", "People_ID", "Snatch", "Clean_Jerk", "Total") VALUES (1, 1, 200.0, 100.0, 300.0);
INSERT INTO "body_builder" ("Body_Builder_ID", "People_ID", "Snatch", "Clean_Jerk", "Total") VALUES (2, 2, 150.0, 200.0, 350.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT clean_jerk FROM (SELECT * FROM (SELECT * FROM body_builder ORDER BY snatch DESC, body_builder.body_builder_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT Clean_Jerk FROM body_builder ORDER BY Total DESC, body_builder.body_builder_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(200.0,)
*/