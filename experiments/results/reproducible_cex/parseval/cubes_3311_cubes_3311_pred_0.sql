-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1, 'lhs_375b37', 1.0, 1.0, 'lhs_ec0d78', 'lhs_7101fb');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483647, 'lhs_91c950', 1.0, 1.0, 'lhs_c2c160', 'lhs_ae67e0');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (2, '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (3, 'hsrwbbp', 503.083789, 320.851235, 'vd', 'tti');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483644, 'q_0_8bd908', 182.319045, 998.421621, 'prmd', 'q_0_f217b1');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483643, 'q_0_8bd908', 792.223623, 938.037625, 'posiie5unw6k', 'q_0_f217b1');

-- Inserting into table: body_builder --
INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (4, 2, 768.216462, 83.204633, 5.585347);

INSERT INTO "body_builder" ("body_builder_id", "people_id", "snatch", "clean_jerk", "total") VALUES (5, 3, 871.191565, 877.276439, 627.258639);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, birth_place FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM body_builder AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name, birth_place NULLS LAST;

/*
Gold Result:
('lhs_375b37', 'lhs_7101fb')
('lhs_91c950', 'lhs_ae67e0')
('q_0_8bd908', 'q_0_f217b1')
('q_0_8bd908', 'q_0_f217b1')
*/

-- Prediction Query
SELECT Name, birth_place FROM people EXCEPT SELECT T1.Name, T1.birth_place FROM people AS T1 JOIN body_builder AS T2 ON T1.people_id = T2.people_id;

/*
Prediction Result:
('lhs_375b37', 'lhs_7101fb')
('lhs_91c950', 'lhs_ae67e0')
('q_0_8bd908', 'q_0_f217b1')
*/