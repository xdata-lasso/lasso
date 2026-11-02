-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('-13', NULL, NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('-34', '-32', '-13');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('-15', NULL, '-20');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('-17', '-32', NULL);
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('-13', '-34', '-17');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('-13', '-13', '-17');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('-32', '-13');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T.bond_type = '-' THEN T.bond_id ELSE NULL END) AS REAL) * 100 / COUNT(T.bond_id) FROM bond AS t;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN b.bond_type = '-' THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(*) AS percentage FROM bond AS b INNER JOIN connected AS c ON b.bond_id = c.bond_id INNER JOIN atom AS a ON c.atom_id = a.atom_id;

/*
Prediction Result:
(0.0,)
*/