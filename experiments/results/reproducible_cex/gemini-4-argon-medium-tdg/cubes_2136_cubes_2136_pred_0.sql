-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs LEFT/RIGHT/FULL JOIN (unmatched users, NULL u_id in review),
-- GROUP BY u_id vs GROUP BY name (same name, different u_id),
-- tie-breaking in ORDER BY (same name, different avg rating; NULL avg rating sorted last),
-- AVG(rating) vs SUM/COUNT/MIN/MAX, AVG(DISTINCT rating), and AVG(rank)/AVG(i_id).
INSERT INTO item (i_id, title) VALUES (10, 'Item A');
INSERT INTO item (i_id, title) VALUES (20, 'Item B');
INSERT INTO useracct (u_id, name) VALUES (1, 'Alice');
INSERT INTO useracct (u_id, name) VALUES (2, 'Bob');
INSERT INTO useracct (u_id, name) VALUES (3, 'Alice');
INSERT INTO useracct (u_id, name) VALUES (4, 'Alice');
INSERT INTO useracct (u_id, name) VALUES (5, 'Charlie');
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (101, 10, 1, 2, 100);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (102, 20, 1, 2, 200);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (103, 10, 1, 5, 300);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (104, 10, 2, 4, 10);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (105, 10, 3, NULL, 50);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (106, 20, 4, 1, 60);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (107, 10, NULL, 5, 10);
INSERT INTO trust (target_u_id, source_u_id, trust) VALUES (1, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, meanrating AS avg_t2_rating_ FROM (SELECT LHS.u_id AS u_id, LHS.name AS name, RHS.meanrating AS meanrating FROM useracct AS LHS INNER JOIN (SELECT u_id, AVG(rating) AS meanrating FROM review GROUP BY u_id) AS RHS ON (LHS.u_id = RHS.u_id)) ORDER BY name, avg_t2_rating_ NULLS LAST;

/*
Gold Result:
('Alice', 1.0)
('Alice', 3.0)
('Alice', None)
('Bob', 4.0)
*/

-- Prediction Query
SELECT T1.name, AVG(T2.rating) FROM useracct AS T1 JOIN review AS T2 ON T1.u_id = T2.u_id GROUP BY T2.u_id;

/*
Prediction Result:
('Alice', 3.0)
('Bob', 4.0)
('Alice', None)
('Alice', 1.0)
*/