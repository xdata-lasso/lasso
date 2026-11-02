-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO item (i_id, title) VALUES (101, 'Laptop');
INSERT INTO item (i_id, title) VALUES (102, 'Mouse');
INSERT INTO item (i_id, title) VALUES (103, 'Keyboard');
INSERT INTO useracct (u_id, name) VALUES (10, 'Zack');
INSERT INTO useracct (u_id, name) VALUES (20, 'Anna');
INSERT INTO useracct (u_id, name) VALUES (30, 'Mike');
INSERT INTO useracct (u_id, name) VALUES (40, 'Bob_NoReviews');
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (1001, 101, 10, 2, 1);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (1002, 102, 10, 2, 2);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (1003, 103, 10, 5, 3);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (1004, 101, 20, 4, 10);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (1005, 102, 20, 5, 20);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (1006, 103, 20, NULL, 30);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (1007, 101, 30, 3, 5);
INSERT INTO trust (target_u_id, source_u_id, trust) VALUES (10, 20, 1);
INSERT INTO trust (target_u_id, source_u_id, trust) VALUES (10, 30, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, meanrating AS avg_t2_rating_ FROM (SELECT LHS.u_id AS u_id, LHS.name AS name, RHS.meanrating AS meanrating FROM useracct AS LHS INNER JOIN (SELECT u_id, AVG(rating) AS meanrating FROM review GROUP BY u_id) AS RHS ON (LHS.u_id = RHS.u_id)) ORDER BY name, avg_t2_rating_ NULLS LAST;

/*
Gold Result:
('Anna', 4.5)
('Mike', 3.0)
('Zack', 3.0)
*/

-- Prediction Query
SELECT T1.name, AVG(T2.rating) FROM useracct AS T1 JOIN review AS T2 ON T1.u_id = T2.u_id GROUP BY T2.u_id;

/*
Prediction Result:
('Zack', 3.0)
('Anna', 4.5)
('Mike', 3.0)
*/