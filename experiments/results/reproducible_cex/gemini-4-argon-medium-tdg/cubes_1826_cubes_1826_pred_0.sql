-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Date, tie-breaking by Debate_ID, duplicate (Date, Venue) pairs (to catch erroneous DISTINCT), and extraneous joins with debate_people (unreferenced debates vs multiple references).
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (1, 'District 1', 'Alice', 'Party A', 40);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (2, 'District 2', 'Bob', 'Party B', 45);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (3, 'District 3', 'Charlie', 'Party A', 50);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (10, '2023-05-10', 'Hall B', 200);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (5, '2023-05-10', 'Hall A', 300);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (20, '2023-01-15', 'Hall C', 150);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (15, '2023-05-10', 'Hall A', 250);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (10, 1, 2, 1);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (10, 2, 3, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, venue FROM debate ORDER BY date, debate.debate_id NULLS LAST;

/*
Gold Result:
('2023-01-15', 'Hall C')
('2023-05-10', 'Hall A')
('2023-05-10', 'Hall B')
('2023-05-10', 'Hall A')
*/

-- Prediction Query
SELECT Date, Venue FROM debate;

/*
Prediction Result:
('2023-05-10', 'Hall A')
('2023-05-10', 'Hall B')
('2023-05-10', 'Hall A')
('2023-01-15', 'Hall C')
*/