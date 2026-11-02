-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (1, 'D1', 'Alice', 'PartyA', 30);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (2, 'D1', 'Bob', 'PartyA', 35);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (3, 'D1', 'Charlie', 'PartyB', 40);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (4, 'D2', 'David', 'PartyB', 45);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (5, 'D3', 'Eve', 'PartyB', 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT * FROM (SELECT * FROM (SELECT district, party, MAX(n) AS maxn FROM (SELECT district, party, COUNT(*) AS n FROM people GROUP BY district, party) GROUP BY district, party) ORDER BY maxn DESC) LIMIT 1);

/*
Gold Result:
('PartyA',)
*/

-- Prediction Query
SELECT Party FROM people GROUP BY Party ORDER BY COUNT(*) DESC, Party NULLS LAST LIMIT 1;

/*
Prediction Result:
('PartyB',)
*/