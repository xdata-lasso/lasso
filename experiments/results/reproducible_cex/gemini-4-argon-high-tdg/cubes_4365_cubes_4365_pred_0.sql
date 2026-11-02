-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (1, 'D1', 'Alice', 'Alpha', 50);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (2, 'D1', 'Bob', 'Alpha', 50);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (3, 'D1', 'Charlie', 'Gamma', 40);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (4, 'D1', 'David', 'Gamma', 40);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (5, 'D1', 'Eve', 'Gamma', 40);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (6, 'D1', 'Frank', 'Delta', 30);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (7, 'D1', 'Grace', 'Delta', 30);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (8, 'D2', 'Heidi', 'Alpha', 50);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (9, 'D2', 'Ivan', 'Beta', 20);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (10, 'D2', 'Judy', 'Beta', 20);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (11, 'D2', 'Karl', 'Beta', 20);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (12, 'D2', 'Leo', 'Beta', 20);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (13, 'D2', 'Mallory', 'Alpha', 50);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (14, 'D3', 'Nina', 'Alpha', 50);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (15, 'D3', 'Oscar', 'Alpha', 50);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (16, 'D3', 'Peggy', 'Alpha', 50);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (17, 'D4', 'Quentin', 'Omega', 90);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (101, '2023-01-10', 'Hall A', 500);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (101, 1, 3, 1);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (101, 2, 4, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT * FROM (SELECT * FROM (SELECT district, party, MAX(n) AS maxn FROM (SELECT district, party, COUNT(*) AS n FROM people GROUP BY district, party) GROUP BY district, party) ORDER BY maxn DESC) LIMIT 1);

/*
Gold Result:
('Beta',)
*/

-- Prediction Query
SELECT Party FROM people GROUP BY Party ORDER BY COUNT(*) DESC, Party NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha',)
*/