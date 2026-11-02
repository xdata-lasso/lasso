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
-- Inserting into table: udaxih --
INSERT INTO "udaxih" ("utlsgw", "cbvhyj", "chdmio") VALUES (1, 'Engineering', 'uda_f6f47b');

INSERT INTO "udaxih" ("utlsgw", "cbvhyj", "chdmio") VALUES (3, 'cbvhyj_2', 'uda_f6f47b');

INSERT INTO "udaxih" ("utlsgw", "cbvhyj", "chdmio") VALUES (2, 'A', 'uda_f6f47b');

INSERT INTO "udaxih" ("utlsgw", "cbvhyj", "chdmio") VALUES (4, '@', 'uda_f6f47b');

-- Inserting into table: hexdvx --
INSERT INTO "hexdvx" ("ulfllg", "viwvuc", "utlsgw", "tufrxh", "fomiuw") VALUES (1, 'e_s_92de1a', 1, 'hex_d6b5f8', 1);

INSERT INTO "hexdvx" ("ulfllg", "viwvuc", "utlsgw", "tufrxh", "fomiuw") VALUES (2, 'e_s_92de1a', 1, 'hex_d6b5f8', 1);

INSERT INTO "hexdvx" ("ulfllg", "viwvuc", "utlsgw", "tufrxh", "fomiuw") VALUES (3, 'e_s_8c5ccd', 1, 'hex_d6b5f8', 1);

INSERT INTO "hexdvx" ("ulfllg", "viwvuc", "utlsgw", "tufrxh", "fomiuw") VALUES (4, 'hex_41df58', 2, 'hex_d6b5f8', 1);

INSERT INTO "hexdvx" ("ulfllg", "viwvuc", "utlsgw", "tufrxh", "fomiuw") VALUES (5, 'hex_41df58', 4, 'hex_d6b5f8', 2);

-- Inserting into table: rcsnba --
INSERT INTO "rcsnba" ("rhvkyy", "bhbzkm", "utlsgw", "icgswk", "gupmuo") VALUES (-2147483648, 'bhbzkm_1', 1, 165.344793, 'rcs_c0ca07');

INSERT INTO "rcsnba" ("rhvkyy", "bhbzkm", "utlsgw", "icgswk", "gupmuo") VALUES (-2147483647, 'bhbzkm_2', 3, 38.668834, 'rcs_c0ca07');

INSERT INTO "rcsnba" ("rhvkyy", "bhbzkm", "utlsgw", "icgswk", "gupmuo") VALUES (-2147483646, 'bhbzkm_3', 1, 475.173408, 'rcs_c0ca07');

INSERT INTO "rcsnba" ("rhvkyy", "bhbzkm", "utlsgw", "icgswk", "gupmuo") VALUES (-2147483645, 'bhbzkm_4', 3, 520.784135, 'rcs_c0ca07');

INSERT INTO "rcsnba" ("rhvkyy", "bhbzkm", "utlsgw", "icgswk", "gupmuo") VALUES (-2147483644, 'bhbzkm_5', 3, 134.487977, 'rcs_c0ca07');

INSERT INTO "rcsnba" ("rhvkyy", "bhbzkm", "utlsgw", "icgswk", "gupmuo") VALUES (-2147483643, 'bhbzkm_6', 3, 378.476082, 'rcs_c0ca07');

INSERT INTO "rcsnba" ("rhvkyy", "bhbzkm", "utlsgw", "icgswk", "gupmuo") VALUES (-2147483642, 'bhbzkm_7', 1, 294.861575, 'rcs_c0ca07');

INSERT INTO "rcsnba" ("rhvkyy", "bhbzkm", "utlsgw", "icgswk", "gupmuo") VALUES (-2147483641, 'bhbzkm_8', 1, 994.117864, 'rcs_c0ca07');

INSERT INTO "rcsnba" ("rhvkyy", "bhbzkm", "utlsgw", "icgswk", "gupmuo") VALUES (-2147483640, 'bhbzkm_9', 3, 737.440743, 'rcs_c0ca07');

INSERT INTO "rcsnba" ("rhvkyy", "bhbzkm", "utlsgw", "icgswk", "gupmuo") VALUES (-2147483639, 'bhbzkm_10', 1, 303.05704, 'rcs_c0ca07');

-- Inserting into table: cghqta --
INSERT INTO "cghqta" ("eiehxr", "ulfllg", "rhvkyy", "rixsns", "mlheqp") VALUES (-2147483648, 1, -2147483648, 'cgh_11d497', 285.529132);

INSERT INTO "cghqta" ("eiehxr", "ulfllg", "rhvkyy", "rixsns", "mlheqp") VALUES (-2147483647, 1, -2147483647, 'cgh_11d497', 292.730571);

INSERT INTO "cghqta" ("eiehxr", "ulfllg", "rhvkyy", "rixsns", "mlheqp") VALUES (-2147483646, 1, -2147483646, 'cgh_11d497', 935.695299);

INSERT INTO "cghqta" ("eiehxr", "ulfllg", "rhvkyy", "rixsns", "mlheqp") VALUES (-2147483645, 1, -2147483645, 'cgh_11d497', 86.520366);

INSERT INTO "cghqta" ("eiehxr", "ulfllg", "rhvkyy", "rixsns", "mlheqp") VALUES (-2147483644, 3, -2147483648, 'cgh_11d497', 483.665643);

INSERT INTO "cghqta" ("eiehxr", "ulfllg", "rhvkyy", "rixsns", "mlheqp") VALUES (-2147483643, 3, -2147483644, 'cgh_11d497', 941.961117);

INSERT INTO "cghqta" ("eiehxr", "ulfllg", "rhvkyy", "rixsns", "mlheqp") VALUES (-2147483642, 3, -2147483643, 'cgh_11d497', 783.93201);

INSERT INTO "cghqta" ("eiehxr", "ulfllg", "rhvkyy", "rixsns", "mlheqp") VALUES (-2147483641, 1, -2147483643, 'cgh_11d497', 759.708817);

INSERT INTO "cghqta" ("eiehxr", "ulfllg", "rhvkyy", "rixsns", "mlheqp") VALUES (-2147483640, 1, -2147483642, 'cgh_11d497', 268.234631);

INSERT INTO "cghqta" ("eiehxr", "ulfllg", "rhvkyy", "rixsns", "mlheqp") VALUES (-2147483639, 1, -2147483641, 'cgh_11d497', 749.826493);

INSERT INTO "cghqta" ("eiehxr", "ulfllg", "rhvkyy", "rixsns", "mlheqp") VALUES (-2147483638, 1, -2147483640, 'cgh_11d497', 334.878198);

INSERT INTO "cghqta" ("eiehxr", "ulfllg", "rhvkyy", "rixsns", "mlheqp") VALUES (-2147483637, 1, -2147483639, 'cgh_11d497', 125.12763);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.ulfllg, e.viwvuc, d.cbvhyj FROM hexdvx AS e JOIN udaxih AS d ON e.utlsgw = d.utlsgw WHERE e.fomiuw = 1 AND d.cbvhyj = 'Engineering' AND NOT EXISTS(SELECT 1 FROM rgwuwr AS t WHERE t.fzvntc = e.ulfllg AND t.gupmuo = 'OVERDUE') AND EXISTS(SELECT 1 FROM cghqta AS a JOIN rcsnba AS p ON a.rhvkyy = p.rhvkyy WHERE a.ulfllg = e.ulfllg AND p.gupmuo = 'ACTIVE');

/*
Gold Result:
*/

-- Prediction Query
SELECT e.ulfllg, e.viwvuc, d.cbvhyj FROM hexdvx AS e JOIN udaxih AS d ON e.utlsgw = d.utlsgw WHERE e.fomiuw = 1 AND d.cbvhyj = 'Engineering' AND NOT EXISTS(SELECT 1 FROM rgwuwr AS t WHERE t.fzvntc = e.ulfllg AND t.gupmuo = 'OVERDUE') AND EXISTS(SELECT 1 FROM cghqta AS a WHERE a.ulfllg = e.ulfllg);

/*
Prediction Result:
(1, 'e_s_92de1a', 'Engineering')
(3, 'e_s_8c5ccd', 'Engineering')
*/