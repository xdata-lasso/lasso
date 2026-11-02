-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR00120', 'TR001', 'TR00123');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR00121', 'TR001', 'TR00123');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR00115', 'TR001', 'TR001');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR00114', 'TR001', 'TR001');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR00121', 'TR00121', 'TR00114');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR00120', 'TR00120', 'TR00114');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR00113', 'TR001');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR001', 'TR00122');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR001';

/*
Gold Result:
('TR00123',)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR001';

/*
Prediction Result:
('TR00123',)
('TR00123',)
*/