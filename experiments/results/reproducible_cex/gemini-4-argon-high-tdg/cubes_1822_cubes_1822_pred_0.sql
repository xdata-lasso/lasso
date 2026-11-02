-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (1, 'North', 'John', 'Dem', 40);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (2, 'South', 'John', 'Rep', 55);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (3, 'East', 'Mary', 'Dem', 35);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (4, 'West', 'Mary', 'Ind', 48);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (5, 'Central', 'Aaron', 'Rep', 62);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (6, 'West', 'Zoe', 'Dem', 29);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (101, '2021-05-01', 'Center 1', 500);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (102, '2021-05-02', 'Center 2', 450);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (103, '2021-05-03', 'Center 3', 600);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (104, '2021-05-04', 'Center 4', 550);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (101, 1, 6, 1);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (102, 1, 6, 0);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (103, 1, 6, 1);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (101, 2, 6, 0);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (101, 3, 6, 1);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (102, 3, 6, 1);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (103, 4, 6, 0);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (104, 4, 6, 1);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (101, 5, 6, 1);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (102, 5, 6, 1);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (103, 5, 6, 0);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (104, 5, 6, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.people_id AS people_id, LHS.district AS district, LHS.name AS name, LHS.party AS party, LHS.age AS age, RHS.n AS n FROM people AS LHS INNER JOIN (SELECT affirmative, COUNT(*) AS n FROM debate_people GROUP BY affirmative) AS RHS ON (LHS.people_id = RHS.affirmative)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Aaron', 4)
('John', 1)
('John', 3)
('Mary', 2)
('Mary', 2)
*/

-- Prediction Query
SELECT T2.Name, COUNT(*) FROM debate_people AS T1 JOIN people AS T2 ON T1.Affirmative = T2.People_ID GROUP BY T2.Name;

/*
Prediction Result:
('Aaron', 4)
('John', 4)
('Mary', 4)
*/