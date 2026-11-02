-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO item (i_id, title) VALUES (1, 'Zebra');
INSERT INTO item (i_id, title) VALUES (2, 'Apple');
INSERT INTO item (i_id, title) VALUES (3, 'Mango');
INSERT INTO item (i_id, title) VALUES (4, 'Unreviewed');
INSERT INTO item (i_id, title) VALUES (5, 'WrongKeyRank');
INSERT INTO item (i_id, title) VALUES (6, 'Banana');
INSERT INTO item (i_id, title) VALUES (10, 'WrongKeyRating');
INSERT INTO item (i_id, title) VALUES (100, 'WrongKeyAid');
INSERT INTO item (i_id, title) VALUES (200, 'WrongKeyUid');
INSERT INTO useracct (u_id, name) VALUES (1, 'UserOne');
INSERT INTO useracct (u_id, name) VALUES (200, 'UserAlpha');
INSERT INTO useracct (u_id, name) VALUES (201, 'UserBeta');
INSERT INTO useracct (u_id, name) VALUES (202, 'UserGamma');
INSERT INTO trust (target_u_id, source_u_id, trust) VALUES (200, 201, 1);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (100, 1, 200, 10, 5);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (101, 2, 201, 10, 1);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (102, 3, 200, 9, 10);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (103, 3, 201, 11, 2);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (104, 6, 202, 10, 0);
INSERT INTO review (a_id, i_id, u_id, rating, rank) VALUES (10, 3, 1, NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.a_id AS a_id, LHS.u_id AS u_id, LHS.i_id AS i_id, LHS.rating AS rating, LHS.rank AS rank, RHS.title AS title FROM (SELECT * FROM review WHERE (rating = 10)) AS LHS LEFT JOIN item AS RHS ON (LHS.i_id = RHS.i_id)) ORDER BY title;

/*
Gold Result:
('Apple',)
('Banana',)
('Zebra',)
*/

-- Prediction Query
SELECT T1.title FROM item AS T1 JOIN review AS T2 ON T1.i_id = T2.i_id WHERE T2.rating = 10;

/*
Prediction Result:
('Zebra',)
('Apple',)
('Banana',)
*/