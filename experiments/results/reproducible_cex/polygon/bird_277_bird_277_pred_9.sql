-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR000_1_219', NULL, 'TR005_16_2624');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR005_16_2618', NULL, 'TR000_1_225');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR005_16_26', 'TR005_16_2614', 'TR005_16_2618');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR005_16_2618', 'TR000_1_219', 'TR005_16_26');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR005_16_2614', 'TR005_16_2618');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR000_1_215', 'TR005_16_2618');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR005_16_26';

/*
Gold Result:
('TR000_1_225',)
*/

-- Prediction Query
SELECT DISTINCT "atom"."element" FROM "connected" INNER JOIN "atom" ON "connected"."atom_id" = "atom"."atom_id" OR "connected"."atom_id2" = "atom"."atom_id" WHERE "connected"."bond_id" = 'TR000_1_2';

/*
Prediction Result:
*/