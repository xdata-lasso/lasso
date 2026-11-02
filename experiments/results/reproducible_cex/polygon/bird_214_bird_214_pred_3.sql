-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('sn22', 'sn24', 'sn23');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('sn25', 'sn27', 'sn26');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('sn16', 'sn27', 'sn28');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('sn15', 'sn27', 'sn28');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('sn24', 'sn28');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('sn27', 'sn28');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 'sn';

/*
Gold Result:
('sn28',)
*/

-- Prediction Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 'sn';

/*
Prediction Result:
('sn28',)
('sn28',)
*/