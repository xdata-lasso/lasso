-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1009, 'decide', 'Meredith Barnes', 'blue', 1013);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1010, 'decide', 'Donald Booth', 'blue', 1024.0);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1011, 'decide', 'Caitlin Henderson', 'blue', 1035.0);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1012, 'decide', 'Daniel Gallagher', 'blue', 1046.0);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1017, NULL, 'Ian Cooper', 'high', 1021);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1018, NULL, 'Andrew Stevens', 'high', 1032.0);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1019, NULL, 'Thomas Miller', 'high', 1043.0);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1020, NULL, 'Mark Mcclure', 'high', 1054.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT * FROM (SELECT * FROM (SELECT district, party, MAX(n) AS maxn FROM (SELECT district, party, COUNT(*) AS n FROM people GROUP BY district, party) GROUP BY district, party) ORDER BY maxn DESC) LIMIT 1);

/*
Gold Result:
('high',)
*/

-- Prediction Query
SELECT Party FROM people GROUP BY Party ORDER BY COUNT(*) DESC, Party NULLS LAST LIMIT 1;

/*
Prediction Result:
('blue',)
*/