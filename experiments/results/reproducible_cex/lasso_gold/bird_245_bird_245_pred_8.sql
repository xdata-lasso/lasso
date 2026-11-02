-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('table', 'true');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('human', 'bar');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('according', 'table', 'i');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('old', 'human', 'i');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('collection', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('production', NULL, NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('song', 'table', 'sure');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('finally', 'human', 'themselves');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('according', 'collection', 'song');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('old', 'production', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.bond_id) AS REAL) / COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 'i';

/*
Gold Result:
(0.5,)
*/

-- Prediction Query
SELECT COUNT(*) / COUNT(DISTINCT T1.atom_id) AS average_bonds FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T2.element = 'i';

/*
Prediction Result:
(1,)
*/