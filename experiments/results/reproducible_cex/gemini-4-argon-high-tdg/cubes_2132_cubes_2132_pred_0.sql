-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO item (i_id, title) VALUES (100, 'Book');
INSERT INTO item (i_id, title) VALUES (200, 'Movie');
INSERT INTO useracct (u_id, name) VALUES (10, 'Charlie');
INSERT INTO useracct (u_id, name) VALUES (20, 'Alice');
INSERT INTO useracct (u_id, name) VALUES (30, 'Bob');
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (1, 100, 20, 3, NULL);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (2, 100, 20, 3, 10);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (3, 200, 20, 3, 2);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (4, 100, 20, 2, 3);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (5, 100, 20, 4, 3);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (6, 200, 10, 3, 1);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (7, 100, 30, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, rank AS count___ FROM (SELECT LHS.u_id AS u_id, LHS.name AS name, LHS.n AS n, RHS.a_id AS a_id, RHS.i_id AS i_id, RHS.rank AS rank FROM (SELECT u_id, name, COUNT(*) OVER () AS n FROM useracct) AS LHS INNER JOIN review AS RHS ON (LHS.u_id = RHS.u_id AND LHS.n = RHS.rating)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 2)
('Alice', 10)
('Alice', None)
('Charlie', 1)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM useracct AS T1 JOIN review AS T2 ON T1.u_id = T2.u_id GROUP BY T2.u_id;

/*
Prediction Result:
('Charlie', 1)
('Alice', 5)
('Bob', 1)
*/