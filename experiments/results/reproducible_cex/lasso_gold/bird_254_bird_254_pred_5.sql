-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('machine', 'human');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('not', 'bar');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('capital', 'old');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('win', 'finally');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('themselves', 'machine', 'training');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('production', 'machine', 'high');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('present', 'machine', 'participant');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('value', 'machine', 'dark');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('his', 'machine', 'training');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('spring', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('figure', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('base', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('top', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('early', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('trial', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('blood', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('long', NULL, NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('prove', 'machine', 'drive');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('they', 'machine', 'drive');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('available', NULL, NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('answer', NULL, NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('recently', NULL, NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('sea', NULL, NULL);
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('themselves', 'spring', 'prove');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('themselves', 'figure', 'available');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('themselves', 'base', 'answer');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('themselves', 'top', 'recently');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('themselves', 'early', 'sea');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('themselves', 'trial', 'available');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('themselves', 'blood', 'answer');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('themselves', 'long', 'recently');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('his', 'spring', 'they');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(77.77777777777777,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.bond_type = (SELECT T1.bond_type FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id GROUP BY T1.bond_type ORDER BY COUNT(T1.bond_type) DESC, T1.bond_type NULLS LAST LIMIT 1) THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id;

/*
Prediction Result:
(22.22222222222222,)
*/