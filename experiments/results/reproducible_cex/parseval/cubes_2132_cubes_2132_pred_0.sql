-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: useracct --
INSERT INTO "useracct" ("u_id", "name") VALUES (1, 'use_201a21');

INSERT INTO "useracct" ("u_id", "name") VALUES (-2147483647, 'use_182692');

INSERT INTO "useracct" ("u_id", "name") VALUES (2, 'use_6cb4cf');

INSERT INTO "useracct" ("u_id", "name") VALUES (3, 'use_6cb4cf');

INSERT INTO "useracct" ("u_id", "name") VALUES (4, 'use_6cb4cf');

INSERT INTO "useracct" ("u_id", "name") VALUES (5, 'use_6cb4cf');

INSERT INTO "useracct" ("u_id", "name") VALUES (6, 'use_6cb4cf');

-- Inserting into table: item --
INSERT INTO "item" ("i_id", "title") VALUES (1, 'ite_d9e417');

-- Inserting into table: review --
INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (1, 1, 1, -1437333179, 1);

INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (-2147483647, 1, -2147483647, 1258409369, 1);

INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (2, 1, 1, 1871297066, 809183447);

INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (3, 1, 1, 1744686505, -1633151678);

INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (4, 1, 1, 1268590800, 1219478689);

INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (5, 1, 3, 1465859724, -1349201381);

INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (6, 1, 2, 1526238907, -1377057208);
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
('use_182692', 1)
('use_201a21', 4)
('use_6cb4cf', 1)
('use_6cb4cf', 1)
*/