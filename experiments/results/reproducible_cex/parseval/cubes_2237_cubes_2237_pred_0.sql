-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: representative --
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1, 'lhs_1e8a7c', 'lhs_a1ed43', 'lhs_569411', 'lhs_bbbe66');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT party FROM (SELECT * FROM representative AS LHS WHERE NOT EXISTS(SELECT 1 FROM election AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY party;

/*
Gold Result:
('lhs_569411',)
*/

-- Prediction Query
SELECT T2.Party FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID ORDER BY votes ASC, T1.election_id NULLS LAST, T2.representative_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/