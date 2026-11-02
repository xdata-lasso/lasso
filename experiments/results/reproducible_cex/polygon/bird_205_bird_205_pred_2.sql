-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('si14', NULL, 'si');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('si15', 'si17', 'si');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('si11', 'si17', 'si15');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('si15', 'si15', 'si11');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('si14', 'si15', 'si11');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('si10', 'si15');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('si17', 'si15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.atom_id FROM atom AS T WHERE T.element = 'si';

/*
Gold Result:
('si14',)
('si15',)
*/

-- Prediction Query
SELECT DISTINCT molecule_id FROM atom WHERE element = 'si';

/*
Prediction Result:
(None,)
('si17',)
*/