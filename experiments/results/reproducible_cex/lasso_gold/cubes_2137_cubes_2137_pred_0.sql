-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "item" ("i_id", "title") VALUES (1013, 'Engineering geologist');
INSERT INTO "item" ("i_id", "title") VALUES (1014, 'Air traffic controller');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT * FROM item AS LHS WHERE NOT EXISTS(SELECT 1 FROM review AS RHS WHERE (LHS.i_id = RHS.i_id))) ORDER BY title;

/*
Gold Result:
('Air traffic controller',)
('Engineering geologist',)
*/

-- Prediction Query
SELECT title FROM item WHERE NOT i_id IN (SELECT i_id FROM review);

/*
Prediction Result:
('Engineering geologist',)
('Air traffic controller',)
*/