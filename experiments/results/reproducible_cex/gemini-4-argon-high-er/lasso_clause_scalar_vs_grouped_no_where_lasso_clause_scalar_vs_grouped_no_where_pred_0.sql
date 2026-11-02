-- Schema DDL
CREATE TABLE member (member_id TEXT PRIMARY KEY, first_name TEXT, last_name TEXT);

CREATE TABLE expense (expense_id TEXT PRIMARY KEY, cost REAL, link_to_member TEXT, FOREIGN KEY (link_to_member) REFERENCES member (member_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO member (member_id, first_name, last_name) VALUES ('m1', 'John', 'Doe');
INSERT INTO member (member_id, first_name, last_name) VALUES ('m2', 'Jane', 'Smith');
INSERT INTO expense (expense_id, cost, link_to_member) VALUES ('e1', 10.0, 'm1');
INSERT INTO expense (expense_id, cost, link_to_member) VALUES ('e2', 20.0, 'm2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, SUM(T2.cost) FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member;

/*
Gold Result:
('John', 'Doe', 30.0)
*/

-- Prediction Query
SELECT member.first_name, member.last_name, SUM(expense.cost) AS total_cost FROM member INNER JOIN expense ON member.member_id = expense.link_to_member GROUP BY member.first_name, member.last_name;

/*
Prediction Result:
('Jane', 'Smith', 20.0)
('John', 'Doe', 10.0)
*/