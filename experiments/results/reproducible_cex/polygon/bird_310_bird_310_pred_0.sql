-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=16', '=18', '=18');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('+15', NULL, '=18');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=20', '+17', '+25');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('+19', '=18', '=26');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('+15', '=16', '=20');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('+17', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=18', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.molecule_id), SUM(CASE WHEN T2.label = '+' THEN 1 ELSE 0 END) FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '=';

/*
Gold Result:
(0, None)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.molecule_id) AS TotalMolecules, COUNT(DISTINCT T2.molecule_id) AS CarcinogenicMolecules FROM bond AS T1 LEFT JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id AND T2.label = '+' WHERE T1.bond_type = '=';

/*
Prediction Result:
(0, 0)
*/