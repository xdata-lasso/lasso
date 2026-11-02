-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: journalist --
INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (2, '5k5swwqcgs', 'jou_a2a0d9', '9n8', 0);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (3, '4', 'jou_a2a0d9', 'gu7v', 0);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (4, 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 11);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (5, '5k5swwqcgs', '9n8', '4', 3);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (6, 'gu7v', 'e4', 'hria2ypuzhs', NULL);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (7, 'rwbbp6luhvd', 'tti', 'bnp', NULL);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (8, 'mdpos', 'ie5', 'nw6klf', NULL);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (9, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', NULL);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (10, 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT nationality FROM journalist WHERE (years_working > 10 OR years_working < 3) ORDER BY nationality;

/*
Gold Result:
('hria2ypuzhs',)
('jou_a2a0d9',)
*/

-- Prediction Query
SELECT Nationality FROM journalist WHERE Years_working > 10 INTERSECT SELECT Nationality FROM journalist WHERE Years_working < 3;

/*
Prediction Result:
*/