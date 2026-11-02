-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('c17', 'te26', 'te');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('te16', 'te18', 'c23');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('c25', 'te26', 'te24');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('te28', 'te26', 'c27');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('te16', 'te16', 'c25');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('te16', 'c17', 'te28');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('te18', 'te26');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('te26', 'te26');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'te';

/*
Gold Result:
('c27',)
('te24',)
*/

-- Prediction Query
SELECT DISTINCT "bond"."bond_type" FROM "bond" INNER JOIN "connected" ON "bond"."bond_id" = "connected"."bond_id" INNER JOIN "atom" ON "connected"."atom_id" = "atom"."atom_id" OR "connected"."atom_id2" = "atom"."atom_id" WHERE "atom"."element" = 'c';

/*
Prediction Result:
*/