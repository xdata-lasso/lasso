-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('cl20', 'cl21', 'cl');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('cl27', NULL, 'cl20');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('cl28', 'cl21', 'cl26');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('cl15', NULL, 'cl20');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('cl20', 'cl27', 'cl28');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('cl20', 'cl20', 'cl28');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('cl14', 'cl20');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('cl21', 'cl20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.bond_id) FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T2.element = 'cl';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT bond.bond_id) FROM bond JOIN connected ON bond.bond_id = connected.bond_id JOIN atom ON connected.atom_id = atom.atom_id WHERE atom.element = 'cl';

/*
Prediction Result:
(1,)
*/