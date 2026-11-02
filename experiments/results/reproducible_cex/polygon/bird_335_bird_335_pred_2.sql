-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES (' = 14', '=27', 'o');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('o25', '=27', 'o');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES (' = 26', '=27', ' = ');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('o16', '=27', ' = ');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('o25', 'o25', 'o16');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=27', '=27');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=15', '=27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '=' AND T1.element = 'o';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT a.molecule_id) AS total_molecules FROM atom AS a INNER JOIN bond AS b ON a.molecule_id = b.molecule_id WHERE a.element = 'o' AND b.bond_type = ' = ';

/*
Prediction Result:
(1,)
*/