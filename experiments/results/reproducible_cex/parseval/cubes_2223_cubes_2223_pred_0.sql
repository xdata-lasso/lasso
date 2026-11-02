-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: representative --
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1, 'lhs_685e63', 'lhs_c40d59', 'lhs_a393c9', 'lhs_ab61df');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483648, 'lhs_a607e4', 'lhs_d9541b', 'lhs_072514', 'lhs_da95c9');

-- Inserting into table: election --
INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (1, 1, 'ele_221991', 10000.0, 1.0, 1.0, 1.0);

INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (-2147483648, 1, 'ele_396b66', 10000.0, 1.0, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM representative AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT * FROM election WHERE (votes >= 10000.0)) AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY name;

/*
Gold Result:
('lhs_685e63',)
*/

-- Prediction Query
SELECT T2.Name FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID WHERE Votes > 10000;

/*
Prediction Result:
*/