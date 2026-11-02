-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR34628', 'TR346', 'TR34629');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR34612', 'TR34613', 'TR346');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR34626', 'TR346', 'TR34627');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR34630', 'TR346', 'TR34631');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR34612', 'TR34612', 'TR34626');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR34628', 'TR34612', 'TR34630');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR34613', 'TR346');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR346', 'TR346');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id, COUNT(DISTINCT T2.bond_type) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR346' GROUP BY T1.atom_id, T2.bond_type;

/*
Gold Result:
('TR34628', 1)
('TR34628', 1)
*/

-- Prediction Query
SELECT "atom"."atom_id", COUNT(DISTINCT "bond"."bond_type") AS "bond_type_count" FROM "atom" INNER JOIN "bond" ON "atom"."molecule_id" = "bond"."molecule_id" WHERE "atom"."molecule_id" = 'TR346' GROUP BY "atom"."atom_id";

/*
Prediction Result:
('TR34628', 2)
*/