-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR00419', 'TR004', 'TR00422');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR00421', 'TR004', 'TR00422');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR00414', 'TR004', 'TR004');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR00413', 'TR004', 'TR004');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR00421', 'TR00421', 'TR00413');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR00419', 'TR00419', 'TR00413');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR004', 'TR00420');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR004';

/*
Gold Result:
('TR00422',)
*/

-- Prediction Query
SELECT T2.element FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR004';

/*
Prediction Result:
('TR00422',)
('TR00422',)
*/