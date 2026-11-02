-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('s24', '=27', 's');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('s18', 's28', 's');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=25', '=27', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('s26', 's28', '=');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('s24', 's24', 's26');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('s18', 's18', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('s28', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=27', 's30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 's' AND T2.bond_type = '=';

/*
Gold Result:
('=27',)
('s28',)
*/

-- Prediction Query
SELECT DISTINCT "molecule"."molecule_id" FROM "molecule" INNER JOIN "atom" ON "molecule"."molecule_id" = "atom"."molecule_id" INNER JOIN "connected" ON "atom"."atom_id" = "connected"."atom_id" INNER JOIN "bond" ON "connected"."bond_id" = "bond"."bond_id" WHERE "atom"."element" = 's' AND "bond"."bond_type" = '=';

/*
Prediction Result:
('=27',)
*/