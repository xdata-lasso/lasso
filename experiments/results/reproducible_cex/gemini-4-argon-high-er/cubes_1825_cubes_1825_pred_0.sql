-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (1, 'D1', 'Alice', 'Dem', 30);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (2, 'D1', 'Bob', 'Dem', 30);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (3, 'D2', 'Charlie', 'Rep', 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT * FROM (SELECT * FROM (SELECT age, party, COUNT(*) AS n FROM people GROUP BY age, party) ORDER BY n) LIMIT 1);

/*
Gold Result:
('Rep',)
*/

-- Prediction Query
SELECT Party FROM people GROUP BY Party ORDER BY COUNT(*) DESC, Party NULLS LAST LIMIT 1;

/*
Prediction Result:
('Dem',)
*/