-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('-32', NULL, '-19');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('-29', NULL, '-19');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('-33', '-19', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('-30', '-19', NULL);
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('-29', '-29', '-30');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('-32', '-32', '-33');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('-19', '-25');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('-20', '-19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id WHERE T2.label = '-';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT "connected"."atom_id", "connected"."atom_id2" FROM "connected" INNER JOIN "bond" ON "connected"."bond_id" = "bond"."bond_id" INNER JOIN "molecule" ON "bond"."molecule_id" = "molecule"."molecule_id" WHERE "molecule"."label" = '-';

/*
Prediction Result:
*/