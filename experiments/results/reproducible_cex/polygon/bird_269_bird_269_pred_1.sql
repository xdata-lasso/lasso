-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('i17', 'i21', 'i');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('i26', 'i21', 'i');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('i20', 'i21', 'i30');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('i19', 'i21', 'i31');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('i26', 'i26', 'i19');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('i17', 'i26', 'i19');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('i21', 'i27');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('i18', 'i21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.bond_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T1.element = 'i';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT c.bond_id) FROM connected AS c JOIN atom AS a ON c.atom_id = a.atom_id WHERE a.element = 'i';

/*
Prediction Result:
(1,)
*/