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
-- DATASET 4
INSERT INTO udaxih (utlsgw, cbvhyj, chdmio) VALUES (10, 'Engineering', 'North');
INSERT INTO hexdvx (ulfllg, viwvuc, utlsgw, tufrxh, fomiuw) VALUES (101, 'No_Tasks_Emp', 10, 'Staff', 1);
INSERT INTO hexdvx (ulfllg, viwvuc, utlsgw, tufrxh, fomiuw) VALUES (102, 'Non_Overdue_Task_Emp', 10, 'Staff', 1);
INSERT INTO hexdvx (ulfllg, viwvuc, utlsgw, tufrxh, fomiuw) VALUES (103, 'Overdue_On_Inactive_Proj_Emp', 10, 'Staff', 1);
INSERT INTO hexdvx (ulfllg, viwvuc, utlsgw, tufrxh, fomiuw) VALUES (104, 'Overdue_On_Active_Proj_Emp', 10, 'Staff', 1);
INSERT INTO rcsnba (rhvkyy, bhbzkm, utlsgw, icgswk, gupmuo) VALUES (1000, 'ActiveProj', 10, 80000.0, 'ACTIVE');
INSERT INTO rcsnba (rhvkyy, bhbzkm, utlsgw, icgswk, gupmuo) VALUES (2000, 'InactiveProj', 10, 40000.0, 'CLOSED');
INSERT INTO cghqta (eiehxr, ulfllg, rhvkyy, rixsns, mlheqp) VALUES (1, 101, 1000, 'Member', 30.0);
INSERT INTO cghqta (eiehxr, ulfllg, rhvkyy, rixsns, mlheqp) VALUES (2, 102, 1000, 'Member', 30.0);
INSERT INTO cghqta (eiehxr, ulfllg, rhvkyy, rixsns, mlheqp) VALUES (3, 103, 1000, 'Member', 30.0);
INSERT INTO cghqta (eiehxr, ulfllg, rhvkyy, rixsns, mlheqp) VALUES (4, 104, 1000, 'Member', 30.0);
INSERT INTO rgwuwr (cybdeu, rhvkyy, fzvntc, tufrxh, mmtoqi, gupmuo, ravxdv) VALUES (1, 1000, 102, 'OVERDUE', 'OVERDUE', 'IN_PROGRESS', 'OVERDUE');
INSERT INTO rgwuwr (cybdeu, rhvkyy, fzvntc, tufrxh, mmtoqi, gupmuo, ravxdv) VALUES (2, 2000, 103, 'Legacy Fix', 'LOW', 'OVERDUE', '2024-12-01');
INSERT INTO rgwuwr (cybdeu, rhvkyy, fzvntc, tufrxh, mmtoqi, gupmuo, ravxdv) VALUES (3, 1000, 104, 'Main Feature', 'HIGH', 'OVERDUE', '2025-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.ulfllg, e.viwvuc, d.cbvhyj FROM hexdvx AS e JOIN udaxih AS d ON e.utlsgw = d.utlsgw WHERE e.fomiuw = 1 AND d.cbvhyj = 'Engineering' AND NOT EXISTS(SELECT 1 FROM rgwuwr AS t WHERE t.fzvntc = e.ulfllg AND t.gupmuo = 'OVERDUE') AND EXISTS(SELECT 1 FROM cghqta AS a JOIN rcsnba AS p ON a.rhvkyy = p.rhvkyy WHERE a.ulfllg = e.ulfllg AND p.gupmuo = 'ACTIVE');

/*
Gold Result:
(101, 'No_Tasks_Emp', 'Engineering')
(102, 'Non_Overdue_Task_Emp', 'Engineering')
*/

-- Prediction Query
SELECT e.ulfllg, e.viwvuc, d.cbvhyj FROM hexdvx AS e JOIN udaxih AS d ON e.utlsgw = d.utlsgw WHERE e.fomiuw = 1 AND d.cbvhyj = 'Engineering' AND NOT EXISTS(SELECT 1 FROM rgwuwr AS t WHERE t.fzvntc = e.ulfllg AND t.gupmuo = 'OVERDUE' AND t.mmtoqi <> 'LOW') AND EXISTS(SELECT 1 FROM cghqta AS a JOIN rcsnba AS p ON a.rhvkyy = p.rhvkyy WHERE a.ulfllg = e.ulfllg AND p.gupmuo = 'ACTIVE');

/*
Prediction Result:
(101, 'No_Tasks_Emp', 'Engineering')
(102, 'Non_Overdue_Task_Emp', 'Engineering')
(103, 'Overdue_On_Inactive_Proj_Emp', 'Engineering')
*/