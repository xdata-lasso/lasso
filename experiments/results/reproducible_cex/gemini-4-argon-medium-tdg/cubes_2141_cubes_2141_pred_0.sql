-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO useracct (u_id, name) VALUES (1, 'Alice');
INSERT INTO useracct (u_id, name) VALUES (2, 'Bob');
INSERT INTO useracct (u_id, name) VALUES (3, 'Charlie');
INSERT INTO useracct (u_id, name) VALUES (4, 'David');
INSERT INTO useracct (u_id, name) VALUES (5, 'Eve');
INSERT INTO trust (target_u_id, source_u_id, trust) VALUES (1, 5, 2);
INSERT INTO trust (target_u_id, source_u_id, trust) VALUES (5, 1, 3);
INSERT INTO trust (target_u_id, source_u_id, trust) VALUES (4, 3, 5);
INSERT INTO trust (target_u_id, source_u_id, trust) VALUES (2, 4, 99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT u_id, name, source_u_id, target_u_id, u_id AS trust FROM (SELECT LHS.u_id AS u_id, LHS.name AS name, RHS.source_u_id AS source_u_id, RHS.target_u_id AS target_u_id FROM useracct AS LHS INNER JOIN trust AS RHS ON (LHS.u_id = RHS.trust))) ORDER BY source_u_id DESC) LIMIT 1);

/*
Gold Result:
('Bob',)
*/

-- Prediction Query
SELECT T1.name FROM useracct AS T1 JOIN trust AS T2 ON T1.u_id = T2.target_u_id ORDER BY trust, T1.u_id NULLS LAST, T2.target_u_id NULLS LAST, T2.source_u_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice',)
*/