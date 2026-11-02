-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('YES10', 'NO11', 'TR151');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('+9', 'NO11', 'TR151');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR15112', 'TR151', 'TR151');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('YES10', '+9', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('NO11', 'TR151');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR151', 'TR15116');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.label FROM molecule AS T WHERE T.molecule_id = 'TR151';

/*
Gold Result:
('TR15116',)
*/

-- Prediction Query
SELECT CASE WHEN label = '+' THEN 'YES' ELSE 'NO' END AS is_carcinogenic FROM molecule WHERE molecule_id = 'TR151';

/*
Prediction Result:
('NO',)
*/