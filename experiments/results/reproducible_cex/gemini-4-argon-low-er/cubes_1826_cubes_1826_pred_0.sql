-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (1, '2023-02-01', 'Hall A', 100);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (2, '2023-01-01', 'Hall B', 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, venue FROM debate ORDER BY date, debate.debate_id NULLS LAST;

/*
Gold Result:
('2023-01-01', 'Hall B')
('2023-02-01', 'Hall A')
*/

-- Prediction Query
SELECT Date, Venue FROM debate;

/*
Prediction Result:
('2023-02-01', 'Hall A')
('2023-01-01', 'Hall B')
*/