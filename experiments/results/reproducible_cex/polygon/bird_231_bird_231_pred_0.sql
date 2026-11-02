-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR01822', 'TR01816', 'TR01816');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR01823', NULL, 'TR01816');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR01824', 'TR01816', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR01826', 'TR01816', NULL);
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR01822', 'TR01823', 'TR01824');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR01823', 'TR01823', 'TR01826');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR01816', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_type FROM (SELECT T1.bond_type, COUNT(T1.molecule_id) FROM bond AS T1 WHERE T1.molecule_id = 'TR018' GROUP BY T1.bond_type ORDER BY COUNT(T1.molecule_id) DESC, T1.bond_type NULLS LAST LIMIT 1) AS T;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.bond_type, T3.label FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN molecule AS T3 ON T1.molecule_id = T3.molecule_id WHERE T3.molecule_id = 'TR018' GROUP BY T1.bond_type ORDER BY COUNT(T1.bond_type) DESC, T1.bond_type NULLS LAST, T3.label NULLS LAST LIMIT 1;

/*
Prediction Result:
*/