-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (1, 'D1', 'P1', 'Party_A', 35);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (2, 'D1', 'P2', 'Party_B', 25);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (3, 'D1', 'P3', 'Party_B', 25);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (4, 'D2', 'P4', 'Party_C', 45);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (5, 'D2', 'P5', 'Party_C', 45);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (6, 'D2', 'P6', 'Party_C', 45);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (10, '2023-01-01', 'Hall A', 100);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (10, 2, 4, 1);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (10, 3, 5, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT * FROM (SELECT * FROM (SELECT age, party, COUNT(*) AS n FROM people GROUP BY age, party) ORDER BY n) LIMIT 1);

/*
Gold Result:
('Party_A',)
*/

-- Prediction Query
SELECT Party FROM people GROUP BY Party ORDER BY COUNT(*) DESC, Party NULLS LAST LIMIT 1;

/*
Prediction Result:
('Party_C',)
*/