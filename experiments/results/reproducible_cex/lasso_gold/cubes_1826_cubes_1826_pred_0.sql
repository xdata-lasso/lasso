-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "debate" ("debate_id", "date", "venue", "num_of_audience") VALUES (1006, 'since', 'chair', 1007);
INSERT INTO "debate" ("debate_id", "date", "venue", "num_of_audience") VALUES (1008, 'face', 'election', 1008);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, venue FROM debate ORDER BY date, debate.debate_id NULLS LAST;

/*
Gold Result:
('face', 'election')
('since', 'chair')
*/

-- Prediction Query
SELECT Date, Venue FROM debate;

/*
Prediction Result:
('since', 'chair')
('face', 'election')
*/