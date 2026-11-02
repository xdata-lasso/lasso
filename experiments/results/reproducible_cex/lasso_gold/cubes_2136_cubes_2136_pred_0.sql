-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "item" ("i_id", "title") VALUES (1055, 'Armed forces logistics/support/administrative officer');
INSERT INTO "item" ("i_id", "title") VALUES (1060, 'Multimedia specialist');
INSERT INTO "useracct" ("u_id", "name") VALUES (1056, 'Kimberly Dudley');
INSERT INTO "useracct" ("u_id", "name") VALUES (1061, 'Edward Fuller');
INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (1057, 1055, 1056, 1058, 1059);
INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (1062, 1060, 1061, 1063, 1064);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, meanrating AS avg_t2_rating_ FROM (SELECT LHS.u_id AS u_id, LHS.name AS name, RHS.meanrating AS meanrating FROM useracct AS LHS INNER JOIN (SELECT u_id, AVG(rating) AS meanrating FROM review GROUP BY u_id) AS RHS ON (LHS.u_id = RHS.u_id)) ORDER BY name, avg_t2_rating_ NULLS LAST;

/*
Gold Result:
('Edward Fuller', 1063.0)
('Kimberly Dudley', 1058.0)
*/

-- Prediction Query
SELECT T1.name, AVG(T2.rating) FROM useracct AS T1 JOIN review AS T2 ON T1.u_id = T2.u_id GROUP BY T2.u_id;

/*
Prediction Result:
('Kimberly Dudley', 1058.0)
('Edward Fuller', 1063.0)
*/