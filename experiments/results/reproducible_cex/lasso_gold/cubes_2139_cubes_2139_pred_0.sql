-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "useracct" ("u_id", "name") VALUES (1013, 'Kimberly Dudley');
INSERT INTO "useracct" ("u_id", "name") VALUES (1014, 'Brandon Davis');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM useracct AS LHS WHERE NOT EXISTS(SELECT 1 FROM review AS RHS WHERE (LHS.u_id = RHS.u_id))) ORDER BY name;

/*
Gold Result:
('Brandon Davis',)
('Kimberly Dudley',)
*/

-- Prediction Query
SELECT name FROM useracct WHERE NOT u_id IN (SELECT u_id FROM review);

/*
Prediction Result:
('Kimberly Dudley',)
('Brandon Davis',)
*/