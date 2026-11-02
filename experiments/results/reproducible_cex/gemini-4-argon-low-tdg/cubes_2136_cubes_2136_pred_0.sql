-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests:
-- 1. GROUP BY u_id vs GROUP BY name (two users with identical name 'SameName' having different averages)
-- 2. SELECT DISTINCT mutants (two users with identical name 'DupUser' AND identical average rating)
-- 3. Tie-breaking in ORDER BY name, avg_t2_rating_ (inserted out of order for both name and average rating)
INSERT INTO item (i_id, title) VALUES (1, 'Book');
INSERT INTO useracct (u_id, name) VALUES (1, 'SameName');
INSERT INTO useracct (u_id, name) VALUES (2, 'SameName');
INSERT INTO useracct (u_id, name) VALUES (3, 'DupUser');
INSERT INTO useracct (u_id, name) VALUES (4, 'DupUser');
INSERT INTO useracct (u_id, name) VALUES (5, 'Aaron');
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (1, 1, 1, 10, 1);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (2, 1, 1, 8, 2);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (3, 1, 2, 2, 1);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (4, 1, 3, 5, 1);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (5, 1, 4, 5, 2);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (6, 1, 5, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, meanrating AS avg_t2_rating_ FROM (SELECT LHS.u_id AS u_id, LHS.name AS name, RHS.meanrating AS meanrating FROM useracct AS LHS INNER JOIN (SELECT u_id, AVG(rating) AS meanrating FROM review GROUP BY u_id) AS RHS ON (LHS.u_id = RHS.u_id)) ORDER BY name, avg_t2_rating_ NULLS LAST;

/*
Gold Result:
('Aaron', 1.0)
('DupUser', 5.0)
('DupUser', 5.0)
('SameName', 2.0)
('SameName', 9.0)
*/

-- Prediction Query
SELECT T1.name, AVG(T2.rating) FROM useracct AS T1 JOIN review AS T2 ON T1.u_id = T2.u_id GROUP BY T2.u_id;

/*
Prediction Result:
('SameName', 9.0)
('SameName', 2.0)
('DupUser', 5.0)
('DupUser', 5.0)
('Aaron', 1.0)
*/