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
INSERT INTO udaxih (utlsgw, cbvhyj, chdmio) VALUES (1, 'OVERDUE', 'default2'), (2, 'default2', 'ACTIVE'), (0, 'Engineering', 'default1');
INSERT INTO rcsnba (rhvkyy, utlsgw, bhbzkm, icgswk, gupmuo) VALUES (2, 2, 'ACTIVE', 2.0, 'Engineering'), (0, 1, 'default2', 1.0, 'default1'), (1, 1, 'Engineering', 2.0, 'default1'), (3, 1, 'default1', 1.0, 'ACTIVE'), (4, 0, 'OVERDUE', 2.0, 'default1'), (5, 2, 'unique_5', 2.0, 'ACTIVE'), (6, 0, 'unique_6', 2.0, 'ACTIVE'), (7, 2, 'unique_7', 1.0, 'default1');
INSERT INTO hexdvx (ulfllg, utlsgw, viwvuc, tufrxh, fomiuw) VALUES (0, 1, 'Engineering', 'default2', 2), (2, 1, 'OVERDUE', 'OVERDUE', 2), (1, 1, 'ACTIVE', 'default2', 1), (3, 2, 'default1', 'default1', 1), (4, 2, 'ACTIVE', 'OVERDUE', 1), (5, 1, 'ACTIVE', 'default1', 0), (6, 1, 'OVERDUE', 'ACTIVE', 2), (7, 0, 'default2', 'default2', 0), (8, 2, 'default1', 'Engineering', 1), (9, 1, 'OVERDUE', 'default2', 1), (10, 0, 'Engineering', 'Engineering', 1), (11, 1, 'Engineering', 'ACTIVE', 0), (12, 1, 'default2', 'Engineering', 0), (13, 1, 'Engineering', 'default1', 2), (14, 1, 'OVERDUE', 'OVERDUE', 2), (15, 0, 'default1', 'ACTIVE', 1), (16, 1, 'ACTIVE', 'Engineering', 1), (17, 0, 'OVERDUE', 'ACTIVE', 1), (18, 1, 'default2', 'default1', 2), (19, 0, 'default2', 'ACTIVE', 2), (20, 1, 'default2', 'OVERDUE', 0), (21, 2, 'Engineering', 'OVERDUE', 0), (22, 2, 'ACTIVE', 'default1', 1), (23, 0, 'default2', 'ACTIVE', 1), (24, 1, 'Engineering', 'default2', 1), (25, 0, 'default1', 'ACTIVE', 1), (26, 0, 'default2', 'default1', 2);
INSERT INTO rgwuwr (cybdeu, rhvkyy, fzvntc, tufrxh, mmtoqi, gupmuo, ravxdv) VALUES (2, 6, 6, 'default2', 'ACTIVE', 'ACTIVE', 'default2'), (0, 6, 18, 'ACTIVE', 'Engineering', 'default2', 'ACTIVE'), (1, 7, 26, 'Engineering', 'default2', 'Engineering', 'default2'), (3, 4, 21, 'default2', 'default1', 'ACTIVE', 'OVERDUE'), (4, 1, 26, 'ACTIVE', 'Engineering', 'default1', 'default1'), (5, 1, 26, 'OVERDUE', 'Engineering', 'default1', 'OVERDUE'), (6, 5, 10, 'Engineering', 'ACTIVE', 'OVERDUE', 'ACTIVE'), (7, 3, 9, 'OVERDUE', 'Engineering', 'default2', 'ACTIVE'), (8, 1, 15, 'ACTIVE', 'ACTIVE', 'default1', 'default1'), (9, 0, 7, 'Engineering', 'default2', 'ACTIVE', 'default2'), (10, 0, 12, 'Engineering', 'OVERDUE', 'default2', 'default1'), (11, 3, 24, 'OVERDUE', 'Engineering', 'Engineering', 'ACTIVE');
INSERT INTO cghqta (eiehxr, ulfllg, rhvkyy, rixsns, mlheqp) VALUES (2, 1, 2, 'ACTIVE', 0.0), (1, 0, 0, 'default2', 1.0), (0, 0, 1, 'Engineering', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.ulfllg, e.viwvuc, d.cbvhyj FROM hexdvx AS e JOIN udaxih AS d ON e.utlsgw = d.utlsgw WHERE e.fomiuw = 1 AND d.cbvhyj = 'Engineering' AND NOT EXISTS(SELECT 1 FROM rgwuwr AS t WHERE t.fzvntc = e.ulfllg AND t.gupmuo = 'OVERDUE') AND EXISTS(SELECT 1 FROM cghqta AS a JOIN rcsnba AS p ON a.rhvkyy = p.rhvkyy WHERE a.ulfllg = e.ulfllg AND p.gupmuo = 'ACTIVE');

/*
Gold Result:
*/

-- Prediction Query
SELECT e.ulfllg, e.viwvuc, d.cbvhyj FROM hexdvx AS e JOIN udaxih AS d ON e.utlsgw = d.utlsgw WHERE e.fomiuw = 1 AND d.cbvhyj = 'Engineering' AND NOT EXISTS(SELECT 1 FROM rgwuwr AS t WHERE t.fzvntc = e.ulfllg AND t.gupmuo = 'OVERDUE') AND NOT EXISTS(SELECT 1 FROM cghqta AS a JOIN rcsnba AS p ON a.rhvkyy = p.rhvkyy WHERE a.ulfllg = e.ulfllg AND p.gupmuo = 'ACTIVE');

/*
Prediction Result:
(15, 'default1', 'Engineering')
(17, 'OVERDUE', 'Engineering')
(23, 'default2', 'Engineering')
(25, 'default1', 'Engineering')
*/