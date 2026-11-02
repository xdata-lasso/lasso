-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('te16', 'cl17', 'te');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('te26', 'cl27', 'cl');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('te24', 'cl27', 'te28');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('cl25', 'cl27', NULL);
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('te26', 'te16', 'cl25');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('te16', 'te26', 'cl25');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('cl17', 'cl27');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('cl27', 'cl27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.bond_type FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T3.element = 'te';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT bond.bond_type FROM bond INNER JOIN atom ON bond.molecule_id = atom.molecule_id WHERE atom.element = 'cl';

/*
Prediction Result:
(None,)
('te28',)
*/