-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('b_s_fe198e', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('m_s_76f4c9', 'hria2ypuzhs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('F', '+');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b_s_e6b0e8', 'b_s_fe198e', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 'b_s_fe198e', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'b_s_fe198e', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'b_s_fe198e', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', '@', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B', 'D', 'b_s_0835ae');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('?', 'C', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'B', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 'F', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.label = '+' THEN T1.bond_id ELSE NULL END) AS REAL) * 100 / COUNT(T1.bond_id) FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '-';

/*
Gold Result:
(42.857142857142854,)
*/

-- Prediction Query
SELECT ROUND(CAST(SUM(CASE WHEN M.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(B.bond_id), 5) AS proportion FROM bond AS B INNER JOIN molecule AS M ON B.molecule_id = M.molecule_id WHERE B.bond_type = '-';

/*
Prediction Result:
(42.85714,)
*/