-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (1, 'North', 'Alice', 'Zebra', 25);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (2, 'South', 'Bob', 'Beta', 30);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (3, 'East', 'Charlie', 'Alpha', 25);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (4, 'West', 'David', 'Alpha', 25);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (5, 'Central', 'Eve', 'Gamma', 40);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (101, '2023-01-10', 'City Hall', 150);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (102, '2023-02-15', 'Civic Center', 300);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (101, 2, 5, 1);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (101, 3, 2, 0);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (102, 5, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT LHS.age AS age, RHS.people_id AS people_id, RHS.district AS district, RHS.name AS name, RHS.party AS party, RHS.age AS age_other FROM (SELECT MIN(age) AS age FROM people) AS LHS CROSS JOIN people AS RHS) WHERE (age = age_other) ORDER BY party;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zebra',)
*/

-- Prediction Query
SELECT Party FROM people ORDER BY Age ASC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zebra',)
*/