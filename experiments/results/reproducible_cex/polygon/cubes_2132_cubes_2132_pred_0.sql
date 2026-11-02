-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "item" ("i_id", "title") VALUES (16, '19');
INSERT INTO "item" ("i_id", "title") VALUES (13, '19');
INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (15, 16, 17, 0, 1);
INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (14, 16, 18, 22, 23);
INSERT INTO "useracct" ("u_id", "name") VALUES (17, NULL);
INSERT INTO "useracct" ("u_id", "name") VALUES (18, NULL);
INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (17, 18, 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, rank AS count___ FROM (SELECT LHS.u_id AS u_id, LHS.name AS name, LHS.n AS n, RHS.a_id AS a_id, RHS.i_id AS i_id, RHS.rank AS rank FROM (SELECT u_id, name, COUNT(*) OVER () AS n FROM useracct) AS LHS INNER JOIN review AS RHS ON (LHS.u_id = RHS.u_id AND LHS.n = RHS.rating)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM useracct AS T1 JOIN review AS T2 ON T1.u_id = T2.u_id GROUP BY T2.u_id;

/*
Prediction Result:
(None, 1)
(None, 1)
*/