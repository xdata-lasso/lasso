-- Schema DDL
/* Relational schema for MMRO-BM (ManyMutationsRandomObfuscated: Random Letter Strings) */ /* Relational schema for ManyMutantsBM benchmark suite. */ /* Universal schema compatible with SQLite, PostgreSQL, and MySQL. */ CREATE TABLE udaxih (utlsgw INTEGER PRIMARY KEY, cbvhyj TEXT(100) NOT NULL UNIQUE, chdmio TEXT(100) NOT NULL);

CREATE TABLE hexdvx (ulfllg INTEGER PRIMARY KEY, viwvuc TEXT(100) NOT NULL, utlsgw INTEGER NOT NULL, tufrxh TEXT(50) NOT NULL, fomiuw INTEGER NOT NULL DEFAULT 1, FOREIGN KEY (utlsgw) REFERENCES udaxih (utlsgw));

CREATE TABLE rcsnba (rhvkyy INTEGER PRIMARY KEY, bhbzkm TEXT(100) NOT NULL UNIQUE, utlsgw INTEGER NOT NULL, icgswk REAL NOT NULL, gupmuo TEXT(20) NOT NULL, FOREIGN KEY (utlsgw) REFERENCES udaxih (utlsgw));

CREATE TABLE cghqta (eiehxr INTEGER PRIMARY KEY, ulfllg INTEGER NOT NULL, rhvkyy INTEGER NOT NULL, rixsns TEXT(20) NOT NULL, mlheqp REAL NOT NULL, UNIQUE (ulfllg, rhvkyy), FOREIGN KEY (ulfllg) REFERENCES hexdvx (ulfllg), FOREIGN KEY (rhvkyy) REFERENCES rcsnba (rhvkyy));

CREATE TABLE rgwuwr (cybdeu INTEGER PRIMARY KEY, rhvkyy INTEGER NOT NULL, fzvntc INTEGER, tufrxh TEXT(200) NOT NULL, mmtoqi TEXT(20) NOT NULL, gupmuo TEXT(20) NOT NULL, ravxdv TEXT(20) NOT NULL, FOREIGN KEY (rhvkyy) REFERENCES rcsnba (rhvkyy), FOREIGN KEY (fzvntc) REFERENCES hexdvx (ulfllg));

CREATE TABLE nhosiz (ryiyuk INTEGER PRIMARY KEY, djnfoa TEXT(100) NOT NULL, xxiqyf TEXT(20) NOT NULL, fomiuw INTEGER NOT NULL DEFAULT 1);

CREATE TABLE ayzfwn (qdujuq INTEGER PRIMARY KEY, ryiyuk INTEGER NOT NULL, tgelyf TEXT(20) NOT NULL, ryqatk TEXT(20) NOT NULL, padlzj TEXT(20) NOT NULL DEFAULT 'STANDARD', hbhscc REAL NOT NULL DEFAULT 0, FOREIGN KEY (ryiyuk) REFERENCES nhosiz (ryiyuk));

CREATE TABLE kiegyk (xpcyry INTEGER PRIMARY KEY, eevprf TEXT(100) NOT NULL UNIQUE, iqtngr TEXT(50) NOT NULL);

CREATE TABLE dcmdll (yxwgwj INTEGER PRIMARY KEY, xpcyry INTEGER NOT NULL, mvuloq TEXT(100) NOT NULL, odhhck REAL NOT NULL, asrhsh INTEGER NOT NULL DEFAULT 0, FOREIGN KEY (xpcyry) REFERENCES kiegyk (xpcyry));

CREATE TABLE tizbxo (acwubh INTEGER PRIMARY KEY, qdujuq INTEGER NOT NULL, yxwgwj INTEGER NOT NULL, cbkcqh INTEGER NOT NULL, ivpgre REAL NOT NULL, xssphz REAL, UNIQUE (qdujuq, yxwgwj), FOREIGN KEY (qdujuq) REFERENCES ayzfwn (qdujuq), FOREIGN KEY (yxwgwj) REFERENCES dcmdll (yxwgwj));

CREATE TABLE rdmcrj (pzngdd INTEGER PRIMARY KEY, yxwgwj INTEGER NOT NULL, ryiyuk INTEGER NOT NULL, vnlnno INTEGER NOT NULL, xbvuud INTEGER NOT NULL DEFAULT 0, bmxkzd TEXT(20) NOT NULL, FOREIGN KEY (yxwgwj) REFERENCES dcmdll (yxwgwj), FOREIGN KEY (ryiyuk) REFERENCES nhosiz (ryiyuk));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "udaxih" ("utlsgw", "cbvhyj", "chdmio") VALUES (26, 'COMPLETED24', 'COMPLETED35');
INSERT INTO "udaxih" ("utlsgw", "cbvhyj", "chdmio") VALUES (25, 'COMPLETED23', 'COMPLETED35');
INSERT INTO "hexdvx" ("ulfllg", "utlsgw", "viwvuc", "tufrxh", "fomiuw") VALUES (27, 26, 'COMPLETED35', 'COMPLETED35', 35);
INSERT INTO "rcsnba" ("rhvkyy", "utlsgw", "bhbzkm", "icgswk", "gupmuo") VALUES (28, 26, 'COMPLETED35', 35, 'COMPLETED35');
INSERT INTO "rgwuwr" ("cybdeu", "rhvkyy", "fzvntc", "tufrxh", "mmtoqi", "gupmuo", "ravxdv") VALUES (33, 28, NULL, 'COMPLETED35', 'COMPLETED35', 'COMPLETED35', 'COMPLETED35');
INSERT INTO "rgwuwr" ("cybdeu", "rhvkyy", "fzvntc", "tufrxh", "mmtoqi", "gupmuo", "ravxdv") VALUES (32, 28, 27, 'COMPLETED35', 'COMPLETED35', 'COMPLETED35', 'COMPLETED35');
INSERT INTO "nhosiz" ("ryiyuk", "djnfoa", "xxiqyf", "fomiuw") VALUES (35, 'COMPLETED46', 'COMPLETED47', 1);
INSERT INTO "nhosiz" ("ryiyuk", "djnfoa", "xxiqyf", "fomiuw") VALUES (69, 'COMPLETED70', 'COMPLETED50', 1);
INSERT INTO "ayzfwn" ("qdujuq", "ryiyuk", "tgelyf", "ryqatk", "padlzj", "hbhscc") VALUES (66, 35, 'COMPLETED67', 'COMPLETED', 'COMPLETED68', 2571);
INSERT INTO "ayzfwn" ("qdujuq", "ryiyuk", "tgelyf", "ryqatk", "padlzj", "hbhscc") VALUES (34, 35, 'COMPLETED48', 'COMPLETED', 'COMPLETED49', -2573);
INSERT INTO "kiegyk" ("xpcyry", "eevprf", "iqtngr") VALUES (36, 'COMPLETED35', 'COMPLETED35');
INSERT INTO "dcmdll" ("yxwgwj", "xpcyry", "mvuloq", "odhhck", "asrhsh") VALUES (39, 36, 'COMPLETED35', 35, 35);
INSERT INTO "dcmdll" ("yxwgwj", "xpcyry", "mvuloq", "odhhck", "asrhsh") VALUES (38, 36, 'COMPLETED35', 35, 35);
INSERT INTO "tizbxo" ("acwubh", "qdujuq", "yxwgwj", "cbkcqh", "ivpgre", "xssphz") VALUES (35, 66, 39, 35, 35, 35);
INSERT INTO "rdmcrj" ("pzngdd", "yxwgwj", "ryiyuk", "vnlnno", "xbvuud", "bmxkzd") VALUES (41, 39, 35, 35, 35, 'COMPLETED35');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.ryiyuk, c.djnfoa, COUNT(o.qdujuq) AS total_orders, COALESCE(SUM(o.hbhscc), 0.0) AS total_spend FROM nhosiz AS c LEFT JOIN ayzfwn AS o ON c.ryiyuk = o.ryiyuk AND o.ryqatk = 'COMPLETED' WHERE c.fomiuw = 1 GROUP BY c.ryiyuk, c.djnfoa;

/*
Gold Result:
(35, 'COMPLETED46', 2, -2.0)
(69, 'COMPLETED70', 0, 0.0)
*/

-- Prediction Query
SELECT c.ryiyuk, c.djnfoa, COUNT(o.qdujuq) AS total_orders, COALESCE(AVG(o.hbhscc), 0.0) AS total_spend FROM nhosiz AS c LEFT JOIN ayzfwn AS o ON c.ryiyuk = o.ryiyuk AND o.ryqatk = 'COMPLETED' WHERE c.fomiuw = 1 GROUP BY c.ryiyuk, c.djnfoa;

/*
Prediction Result:
(35, 'COMPLETED46', 2, -1.0)
(69, 'COMPLETED70', 0, 0.0)
*/