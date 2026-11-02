-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=22', ' = 23', 's');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('s21', 's24', '=34');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES (' = 26', 's24', ' = 32');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=25', ' = 23', 's33');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('s21', '=22', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('s24', ' = 41');
INSERT INTO "molecule" ("molecule_id", "label") VALUES (' = 23', 's42');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 's' AND T2.bond_type <> '=';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT m.molecule_id) FROM molecule AS m LEFT JOIN atom AS a ON m.molecule_id = a.molecule_id LEFT JOIN connected AS c ON a.atom_id = c.atom_id LEFT JOIN bond AS b ON c.bond_id = b.bond_id WHERE a.element <> 's' AND b.bond_type <> ' = ';

/*
Prediction Result:
(0,)
*/