-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (1, 'District 1', 'Person 1', 'Party_A', 20);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (2, 'District 1', 'Person 2', 'Party_A', 20);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (3, 'District 1', 'Person 3', 'Party_A', 20);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (4, 'District 1', 'Person 4', 'Party_A', 20);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (5, 'District 2', 'Person 5', 'Party_C', 30);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (6, 'District 2', 'Person 6', 'Party_C', 30);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (7, 'District 3', 'Person 7', 'Party_M', 35);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (8, 'District 4', 'Person 8', 'Party_Z', 35);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (9, 'District 4', 'Person 9', 'Party_Z', 35);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (10, 'District 4', 'Person 10', 'Party_Z', 35);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (11, 'District 4', 'Person 11', 'Party_Z', 35);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (12, 'District 4', 'Person 12', 'Party_Z', 35);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (13, 'District 5', 'Person 13', 'Party_B', 40);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (14, 'District 5', 'Person 14', 'Party_B', 40);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (15, 'District 5', 'Person 15', 'Party_B', 40);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (16, 'District 3', 'Person 16', 'Party_M', 40);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (17, 'District 3', 'Person 17', 'Party_M', 40);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (18, 'District 3', 'Person 18', 'Party_M', 40);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (19, 'District 3', 'Person 19', 'Party_M', 40);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (20, 'District 3', 'Person 20', 'Party_M', 40);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (21, 'District 3', 'Person 21', 'Party_M', 40);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (22, 'District 2', 'Person 22', 'Party_C', 45);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (23, 'District 2', 'Person 23', 'Party_C', 45);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (24, 'District 2', 'Person 24', 'Party_C', 45);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (25, 'District 2', 'Person 25', 'Party_C', 45);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (26, 'District 2', 'Person 26', 'Party_C', 45);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (27, 'District 2', 'Person 27', 'Party_C', 45);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (28, 'District 2', 'Person 28', 'Party_C', 45);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (29, 'District 6', 'Person 29', 'Party_D', 50);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (30, 'District 6', 'Person 30', 'Party_D', 50);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (31, 'District 6', 'Person 31', 'Party_D', 50);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (32, 'District 6', 'Person 32', 'Party_D', 50);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (33, 'District 6', 'Person 33', 'Party_D', 50);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (34, 'District 6', 'Person 34', 'Party_D', 50);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (35, 'District 6', 'Person 35', 'Party_D', 50);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (36, 'District 6', 'Person 36', 'Party_D', 50);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (37, 'District 6', 'Person 37', 'Party_D', 50);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (38, 'District 6', 'Person 38', 'Party_D', 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT * FROM (SELECT * FROM (SELECT age, party, COUNT(*) AS n FROM people GROUP BY age, party) ORDER BY n) LIMIT 1);

/*
Gold Result:
('Party_M',)
*/

-- Prediction Query
SELECT Party FROM people GROUP BY Party ORDER BY COUNT(*) DESC, Party NULLS LAST LIMIT 1;

/*
Prediction Result:
('Party_D',)
*/