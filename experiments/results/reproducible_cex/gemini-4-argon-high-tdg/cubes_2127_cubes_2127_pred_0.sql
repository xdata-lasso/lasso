-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO item (i_id, title) VALUES (1, 'Book');
INSERT INTO useracct (u_id, name) VALUES (1, 'Alice');
INSERT INTO useracct (u_id, name) VALUES (2, 'Bob');
INSERT INTO useracct (u_id, name) VALUES (3, 'Charlie');
INSERT INTO useracct (u_id, name) VALUES (4, 'David');
INSERT INTO useracct (u_id, name) VALUES (5, 'Aaron');
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (1, 1, 1, 2, 1);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (2, 1, 4, 5, 2);
INSERT INTO trust (target_u_id, source_u_id, trust) VALUES (1, 2, 10);
INSERT INTO trust (target_u_id, source_u_id, trust) VALUES (1, 3, 10);
INSERT INTO trust (target_u_id, source_u_id, trust) VALUES (1, 4, 5);
INSERT INTO trust (target_u_id, source_u_id, trust) VALUES (2, 1, 1);
INSERT INTO trust (target_u_id, source_u_id, trust) VALUES (2, 3, 4);
INSERT INTO trust (target_u_id, source_u_id, trust) VALUES (5, 3, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, meantrust AS avg_trust_ FROM (SELECT name, AVG(trust) AS meantrust FROM (SELECT u_id, name, source_u_id, trust, u_id AS target_u_id FROM (SELECT LHS.u_id AS u_id, LHS.name AS name, RHS.source_u_id AS source_u_id, RHS.trust AS trust FROM useracct AS LHS INNER JOIN trust AS RHS ON (LHS.u_id = RHS.target_u_id))) GROUP BY name) ORDER BY name, avg_trust_ NULLS LAST;

/*
Gold Result:
('Aaron', 5.0)
('Alice', 8.333333333333334)
('Bob', 2.5)
*/

-- Prediction Query
SELECT T1.name, AVG(trust) FROM useracct AS T1 JOIN trust AS T2 ON T1.u_id = T2.target_u_id GROUP BY T2.target_u_id;

/*
Prediction Result:
('Alice', 8.333333333333334)
('Bob', 2.5)
('Aaron', 5.0)
*/