-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR018', 'site');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('purpose', 'face');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('brother', 'election');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ago', 'dog');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('chair', 'TR018', 'sit');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('since', 'TR018', 'sit');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('blue', 'TR018', 'sit');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('require', 'TR018', 'sit');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_type FROM (SELECT T1.bond_type, COUNT(T1.molecule_id) FROM bond AS T1 WHERE T1.molecule_id = 'TR018' GROUP BY T1.bond_type ORDER BY COUNT(T1.molecule_id) DESC, T1.bond_type NULLS LAST LIMIT 1) AS T;

/*
Gold Result:
('sit',)
*/

-- Prediction Query
SELECT b.bond_type, m.label AS is_carcinogenic FROM bond AS b INNER JOIN molecule AS m ON b.molecule_id = m.molecule_id WHERE b.molecule_id = 'TR010' GROUP BY b.bond_type ORDER BY COUNT(b.bond_type) DESC, b.bond_type NULLS LAST, is_carcinogenic NULLS LAST LIMIT 1;

/*
Prediction Result:
*/