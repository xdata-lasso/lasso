-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Grouping by both (district, party) vs grouping ONLY by party.
-- 2. MAX(n) vs SUM(n) across districts.
-- 3. Joining with debate_people (unreferenced people) vs querying 'people' directly.
-- 4. MAX(Age) vs COUNT(*).
-- 5. ORDER BY DESC vs ASC.
-- 6. LIMIT 1 vs no LIMIT.
-- 'Dem' has the highest total count (4 across D1, D2) and highest age (90), and is in debate_people.
-- 'Rep' has the highest count within a SINGLE district (3 in D1), which is what the Reference Query actually selects.
-- 'Ind' has the lowest count (1 in D3) to catch ASC vs DESC mutations.
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (1, 'D1', 'Alice', 'Dem', 90);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (2, 'D1', 'Bob', 'Dem', 80);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (3, 'D2', 'Charlie', 'Dem', 85);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (4, 'D2', 'David', 'Dem', 70);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (5, 'D1', 'Eve', 'Rep', 20);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (6, 'D1', 'Frank', 'Rep', 25);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (7, 'D1', 'Grace', 'Rep', 30);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (8, 'D3', 'Heidi', 'Ind', 40);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (101, '2023-01-01', 'Hall A', 500);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (101, 1, 2, 1);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (101, 3, 4, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT * FROM (SELECT * FROM (SELECT district, party, MAX(n) AS maxn FROM (SELECT district, party, COUNT(*) AS n FROM people GROUP BY district, party) GROUP BY district, party) ORDER BY maxn DESC) LIMIT 1);

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