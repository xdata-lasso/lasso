-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: journalist --
INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483648, 'jou_fc0223', '5k5swwqcgs', 'jou_ba0eb8', 1);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (1, 'lhs_465c1f', 'lhs_d886ea', 'lhs_13c683', 1);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483646, 'rhs_080ba0', '9n8', 'rhs_e6cd74', 1);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483645, NULL, '4', 'jou_ba0eb8', 1);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483644, NULL, 'gu7v', 'rhs_e6cd74', 1);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483643, 'jou_fc0223', 'e4', 'jou_ba0eb8', NULL);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483642, 'rhs_080ba0', 'hria2ypuzhs', 'rhs_e6cd74', NULL);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483641, 'jou_fc0223', 'rwbbp6luhvd', NULL, 1);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483640, 'rhs_080ba0', 'tti', NULL, 1);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483639, 'jou_fc0223', NULL, 'jou_ba0eb8', 1);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483638, 'rhs_080ba0', NULL, 'rhs_e6cd74', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT nationality FROM (SELECT LHS.journalist_id AS journalist_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, LHS.years_working AS years_working, RHS.name AS name_other, RHS.age AS age_other, RHS.years_working AS years_working_other FROM journalist AS LHS INNER JOIN journalist AS RHS ON (LHS.years_working = RHS.journalist_id AND LHS.nationality = RHS.nationality)) ORDER BY nationality;

/*
Gold Result:
('lhs_d886ea',)
*/

-- Prediction Query
SELECT Nationality FROM journalist ORDER BY Years_working DESC, journalist.journalist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('5k5swwqcgs',)
*/