-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('o21', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=20', '=36', 'o');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('o35', '=36', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=38', '=36', 'o37');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('=20', 'o21', '=38');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('o21', 'o21', 'o35');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('o23', 'o21');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=36', 'o21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '=' AND T1.element = 'o';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT b.molecule_id) FROM bond AS b JOIN connected AS c ON b.bond_id = c.bond_id JOIN atom AS a1 ON c.atom_id = a1.atom_id JOIN atom AS a2 ON c.atom_id2 = a2.atom_id WHERE (a1.element = 'o' OR a2.element = 'o') AND b.bond_type = '=';

/*
Prediction Result:
(0,)
*/