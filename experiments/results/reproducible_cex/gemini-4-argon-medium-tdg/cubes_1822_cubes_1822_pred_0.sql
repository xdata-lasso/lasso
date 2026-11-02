-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. GROUP BY people_id vs GROUP BY name (two people with the same name 'Alice' having different counts)
-- 2. INNER JOIN vs LEFT JOIN (person 'Bob' has 0 debates, person 'Charlie' is only in Negative role)
-- 3. Join on Affirmative vs Negative
-- 4. COUNT(*) vs COUNT(DISTINCT Debate_ID) (person 1 has two entries in the same debate with different opponents)
-- 5. ORDER BY name, count___ (ties in name resolved by count___, ties in count___ resolved by name)
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (1, 'D1', 'Alice', 'Dem', 30);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (2, 'D2', 'Alice', 'Rep', 40);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (3, 'D3', 'Bob', 'Dem', 25);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (4, 'D4', 'Charlie', 'Ind', 50);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (5, 'D5', 'Zack', 'Rep', 35);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (10, '2023-01-01', 'Hall A', 100);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (20, '2023-01-02', 'Hall B', 200);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (10, 1, 3, 1);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (10, 1, 4, 0);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (20, 2, 4, NULL);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (20, 5, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.people_id AS people_id, LHS.district AS district, LHS.name AS name, LHS.party AS party, LHS.age AS age, RHS.n AS n FROM people AS LHS INNER JOIN (SELECT affirmative, COUNT(*) AS n FROM debate_people GROUP BY affirmative) AS RHS ON (LHS.people_id = RHS.affirmative)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 1)
('Alice', 2)
('Zack', 1)
*/

-- Prediction Query
SELECT T2.Name, COUNT(*) FROM debate_people AS T1 JOIN people AS T2 ON T1.Affirmative = T2.People_ID GROUP BY T2.Name;

/*
Prediction Result:
('Alice', 3)
('Zack', 1)
*/