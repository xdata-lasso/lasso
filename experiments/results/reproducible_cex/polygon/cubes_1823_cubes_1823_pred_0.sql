-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (8, '11', '15', '12', 36);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (7, NULL, '15', '14', -635);
INSERT INTO "debate" ("debate_id", "date", "venue", "num_of_audience") VALUES (10, '15', '15', 15);
INSERT INTO "debate" ("debate_id", "date", "venue", "num_of_audience") VALUES (9, '15', '15', 15);
INSERT INTO "debate_people" ("debate_id", "affirmative", "negative", "if_affirmative_win") VALUES (9, 7, 8, 1);
INSERT INTO "debate_people" ("debate_id", "affirmative", "negative", "if_affirmative_win") VALUES (9, 7, 7, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people WHERE (age < 35 OR age <= 36) ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
('15',)
('15',)
*/

-- Prediction Query
SELECT Name FROM people WHERE Age = 35 OR Age = 36;

/*
Prediction Result:
('15',)
*/