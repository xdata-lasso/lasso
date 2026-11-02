-- Schema DDL
CREATE TABLE member (member_id TEXT PRIMARY KEY, first_name TEXT, last_name TEXT);

CREATE TABLE expense (expense_id TEXT PRIMARY KEY, cost REAL, link_to_member TEXT, FOREIGN KEY (link_to_member) REFERENCES member (member_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO member (member_id, first_name, last_name) VALUES ('M1', 'Alice', 'Smith');
INSERT INTO member (member_id, first_name, last_name) VALUES ('M2', 'Bob', 'Jones');
INSERT INTO member (member_id, first_name, last_name) VALUES ('M3', 'Charlie', 'Brown');
INSERT INTO expense (expense_id, cost, link_to_member) VALUES ('E1', 100.5, 'M1');
INSERT INTO expense (expense_id, cost, link_to_member) VALUES ('E2', 100.5, 'M1');
INSERT INTO expense (expense_id, cost, link_to_member) VALUES ('E3', 50.25, 'M2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, SUM(T2.cost) FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member;

/*
Gold Result:
('Alice', 'Smith', 251.25)
*/

-- Prediction Query
SELECT member.first_name, member.last_name, SUM(expense.cost) AS total_cost FROM member INNER JOIN expense ON member.member_id = expense.link_to_member GROUP BY member.first_name, member.last_name;

/*
Prediction Result:
('Alice', 'Smith', 201.0)
('Bob', 'Jones', 50.25)
*/