-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('according', 'song');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('sure', 'according', 'sn');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('grow', 'according', 'sn');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('knowledge', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('fall', NULL, NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('collection', 'according', 'save');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('clearly', 'according', 'save');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('sure', 'knowledge', 'collection');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('grow', 'fall', 'clearly');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.bond_type FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T3.bond_id = T2.bond_id WHERE T1.element = 'sn';

/*
Gold Result:
('save',)
*/

-- Prediction Query
SELECT T2.bond_type FROM atom AS T1 INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id INNER JOIN bond AS T2 ON T3.bond_id = T2.bond_id WHERE T1.element = 'sn';

/*
Prediction Result:
('save',)
('save',)
*/