-- Schema DDL
CREATE TABLE RA (A1 TEXT(5) PRIMARY KEY, B TEXT(5));

CREATE TABLE RB (A2 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RA (A1));

CREATE TABLE RC (A3 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RB (A2));

CREATE TABLE RD (A4 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RC (A3));

CREATE TABLE RE (A5 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RD (A4));

CREATE TABLE RF (A6 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RE (A5));

CREATE TABLE RG (A7 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RF (A6));

CREATE TABLE RH (A8 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RG (A7));

CREATE TABLE RI (A9 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RH (A8));

CREATE TABLE RJ (A10 TEXT(5) PRIMARY KEY, B TEXT(5), FOREIGN KEY (B) REFERENCES RI (A9));

-- Loading data
PRAGMA foreign_keys = OFF;
insert into ra values ('2','2');
insert into ra values ('V7','2');
insert into ra values ('V10','3');
insert into ra values ('V11','2');
insert into ra values ('1','2');
insert into rb values ('3',null);
insert into rb values ('1','V10');
insert into rb values ('2','2');
insert into rc values ('2','3');
insert into rd values ('3','2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RA.B FROM RA INNER JOIN RB ON (RA.B = RB.A2) INNER JOIN RC ON (RB.B = RC.A3) INNER JOIN RD ON (RC.B = RD.A4) GROUP BY RA.B HAVING COUNT(RA.B) > 3;

/*
Gold Result:
('2',)
*/

-- Prediction Query
SELECT RA.B FROM RA WHERE 1 = 2;

/*
Prediction Result:
*/