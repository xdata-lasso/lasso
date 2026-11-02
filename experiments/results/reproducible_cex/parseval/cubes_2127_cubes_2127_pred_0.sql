-- Schema DDL
CREATE TABLE "item" ("i_id" INTEGER PRIMARY KEY, "title" TEXT(20));

CREATE TABLE "review" ("a_id" INTEGER PRIMARY KEY, "i_id" INTEGER, "u_id" INTEGER, "rating" INTEGER, "rank" INTEGER, FOREIGN KEY ("i_id") REFERENCES "item" ("i_id"), FOREIGN KEY ("u_id") REFERENCES "useracct" ("u_id"));

CREATE TABLE "useracct" ("u_id" INTEGER PRIMARY KEY, "name" TEXT(128));

CREATE TABLE "trust" ("target_u_id" INTEGER, "source_u_id" INTEGER, "trust" INTEGER, FOREIGN KEY ("target_u_id") REFERENCES "useracct" ("u_id"), FOREIGN KEY ("source_u_id") REFERENCES "useracct" ("u_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: useracct --
INSERT INTO "useracct" ("u_id", "name") VALUES (1, 't1__40bfd3');

INSERT INTO "useracct" ("u_id", "name") VALUES (2, 't1__40bfd3');

INSERT INTO "useracct" ("u_id", "name") VALUES (3, 't1__40bfd3');

-- Inserting into table: trust --
INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 1, -1437333179);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 1, -664303813);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 1, -1981402255);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (2, 2, 247012447);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (2, 3, -1980249628);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (2, 1, 1871297066);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (3, 3, -734455130);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (3, 1, -1633151678);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (3, 1, 1914020640);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (3, 2, 1219478689);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (3, 3, 1115440883);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (3, 2, 1465859724);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (3, 2, 700293388);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (3, 3, -1349201381);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (3, 3, -1659388584);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 1, -1377057208);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 2, -1610064545);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 1, -1257178728);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 2, 2087640001);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 3, 462974032);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 3, -1137908826);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 3, 2026480202);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 1, -1602639011);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 2, -1209887326);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 3, NULL);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 1, NULL);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 1, NULL);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 1, NULL);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 3, NULL);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 1, NULL);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 3, NULL);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 3, NULL);

INSERT INTO "trust" ("target_u_id", "source_u_id", "trust") VALUES (1, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, meantrust AS avg_trust_ FROM (SELECT name, AVG(trust) AS meantrust FROM (SELECT u_id, name, source_u_id, trust, u_id AS target_u_id FROM (SELECT LHS.u_id AS u_id, LHS.name AS name, RHS.source_u_id AS source_u_id, RHS.trust AS trust FROM useracct AS LHS INNER JOIN trust AS RHS ON (LHS.u_id = RHS.target_u_id))) GROUP BY name) ORDER BY name, avg_trust_ NULLS LAST;

/*
Gold Result:
('t1__40bfd3', -271821842.5)
*/

-- Prediction Query
SELECT T1.name, AVG(trust) FROM useracct AS T1 JOIN trust AS T2 ON T1.u_id = T2.target_u_id GROUP BY T2.target_u_id;

/*
Prediction Result:
('t1__40bfd3', -641723388.0)
('t1__40bfd3', 46019961.666666664)
('t1__40bfd3', 115432950.1111111)
*/