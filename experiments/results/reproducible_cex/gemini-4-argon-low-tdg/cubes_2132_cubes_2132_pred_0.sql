-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO item (i_id, title) VALUES (1, 'Item A');
INSERT INTO item (i_id, title) VALUES (2, 'Item B');
INSERT INTO useracct (u_id, name) VALUES (10, 'Alice');
INSERT INTO useracct (u_id, name) VALUES (20, 'Bob');
INSERT INTO useracct (u_id, name) VALUES (30, 'Charlie');
INSERT INTO useracct (u_id, name) VALUES (40, NULL);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (101, 1, 10, 4, 2);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (102, 2, 10, 4, 1);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (103, 1, 10, 4, NULL);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (104, 1, 10, 3, 5);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (105, 1, 20, 4, 10);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (106, 2, 20, 5, 1);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (107, 1, 40, 4, 3);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (108, 1, NULL, 4, 7);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (109, 1, 30, NULL, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, rank AS count___ FROM (SELECT LHS.u_id AS u_id, LHS.name AS name, LHS.n AS n, RHS.a_id AS a_id, RHS.i_id AS i_id, RHS.rank AS rank FROM (SELECT u_id, name, COUNT(*) OVER () AS n FROM useracct) AS LHS INNER JOIN review AS RHS ON (LHS.u_id = RHS.u_id AND LHS.n = RHS.rating)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
(None, 3)
('Alice', 1)
('Alice', 2)
('Alice', None)
('Bob', 10)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM useracct AS T1 JOIN review AS T2 ON T1.u_id = T2.u_id GROUP BY T2.u_id;

/*
Prediction Result:
('Alice', 4)
('Bob', 2)
('Charlie', 1)
(None, 1)
*/