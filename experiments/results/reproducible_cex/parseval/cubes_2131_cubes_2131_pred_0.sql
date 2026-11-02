-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: useracct --
INSERT INTO "useracct" ("u_id", "name") VALUES (1, 'rhs_ef9750');

INSERT INTO "useracct" ("u_id", "name") VALUES (-2147483647, 'rhs_ba3f8e');

INSERT INTO "useracct" ("u_id", "name") VALUES (2, 'rhs_ef9750');

INSERT INTO "useracct" ("u_id", "name") VALUES (3, 'use_6cb4cf');

INSERT INTO "useracct" ("u_id", "name") VALUES (5, 'use_6cb4cf');

INSERT INTO "useracct" ("u_id", "name") VALUES (-2147483643, 'q_2_5b3eae');

INSERT INTO "useracct" ("u_id", "name") VALUES (-2147483642, 'q_2_5b3eae');

-- Inserting into table: item --
INSERT INTO "item" ("i_id", "title") VALUES (-2147483648, 'ite_d9e417');

INSERT INTO "item" ("i_id", "title") VALUES (1, 'ite_d9e417');

-- Inserting into table: review --
INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (1, -2147483648, 1, 1, 1);

INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (-2147483647, 1, -2147483647, 1, 1);

INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (4, 1, 1, 1, 1);

INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (6, 1, 2, -1610064545, 429706943);

INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (3, -2147483648, -2147483642, 462974032, -1137908826);

INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (7, 1, -2147483647, -1602639011, -45536098);

INSERT INTO "review" ("a_id", "i_id", "u_id", "rating", "rank") VALUES (5, -2147483648, 2, -1399556171, 1038707349);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT a_id, u_id, a_id AS i_id, rating, rank, name, a_id_other, rating_other, rank_other FROM (SELECT LHS.a_id AS a_id, LHS.u_id AS u_id, LHS.i_id AS i_id, LHS.rating AS rating, LHS.rank AS rank, LHS.name AS name, RHS.a_id AS a_id_other, RHS.rating AS rating_other, RHS.rank AS rank_other FROM (SELECT a_id, a_id AS u_id, i_id, rating, rank, name FROM (SELECT LHS.a_id AS a_id, LHS.u_id AS u_id, LHS.i_id AS i_id, LHS.rating AS rating, LHS.rank AS rank, RHS.name AS name FROM review AS LHS INNER JOIN useracct AS RHS ON (LHS.a_id = RHS.u_id))) AS LHS INNER JOIN review AS RHS ON (LHS.a_id = RHS.i_id AND LHS.rank = RHS.u_id))) ORDER BY name;

/*
Gold Result:
('rhs_ef9750',)
*/

-- Prediction Query
SELECT T1.name FROM useracct AS T1 JOIN review AS T2 ON T1.u_id = T2.u_id ORDER BY T2.rating DESC, T1.u_id NULLS LAST, T2.a_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_2_5b3eae',)
*/