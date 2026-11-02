-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (8, '14', '14', '14', 14);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (7, '14', '14', '14', 14);
INSERT INTO "debate" ("debate_id", "date", "venue", "num_of_audience") VALUES (10, '14', '12', 151);
INSERT INTO "debate" ("debate_id", "date", "venue", "num_of_audience") VALUES (9, '14', NULL, 150);
INSERT INTO "debate_people" ("debate_id", "affirmative", "negative", "if_affirmative_win") VALUES (9, 8, 7, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM debate WHERE (num_of_audience >= 150) ORDER BY date, debate.debate_id NULLS LAST;

/*
Gold Result:
('14',)
('14',)
*/

-- Prediction Query
SELECT Date FROM debate WHERE Num_of_Audience > 150;

/*
Prediction Result:
('14',)
*/