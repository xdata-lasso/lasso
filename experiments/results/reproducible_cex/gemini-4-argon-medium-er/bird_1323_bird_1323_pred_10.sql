-- Schema DDL
CREATE TABLE event (event_id TEXT CONSTRAINT event_pk PRIMARY KEY, event_name TEXT, event_date TEXT, type TEXT, notes TEXT, location TEXT, status TEXT);

CREATE TABLE major (major_id TEXT CONSTRAINT major_pk PRIMARY KEY, major_name TEXT, department TEXT, college TEXT);

CREATE TABLE zip_code (zip_code INTEGER CONSTRAINT zip_code_pk PRIMARY KEY, type TEXT, city TEXT, county TEXT, state TEXT, short_state TEXT);

CREATE TABLE "attendance" (link_to_event TEXT, link_to_member TEXT, PRIMARY KEY (link_to_event, link_to_member), FOREIGN KEY (link_to_event) REFERENCES event (event_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "budget" (budget_id TEXT PRIMARY KEY, category TEXT, spent REAL, remaining REAL, amount INTEGER, event_status TEXT, link_to_event TEXT, FOREIGN KEY (link_to_event) REFERENCES event (event_id));

CREATE TABLE "expense" (expense_id TEXT PRIMARY KEY, expense_description TEXT, expense_date TEXT, cost REAL, approved TEXT, link_to_member TEXT, link_to_budget TEXT, FOREIGN KEY (link_to_budget) REFERENCES budget (budget_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "income" (income_id TEXT CONSTRAINT income_pk PRIMARY KEY, date_received TEXT, amount INTEGER, source TEXT, notes TEXT, link_to_member TEXT, FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "member" (member_id TEXT CONSTRAINT member_pk PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, position TEXT, t_shirt_size TEXT, phone TEXT, zip INTEGER, link_to_major TEXT, FOREIGN KEY (link_to_major) REFERENCES major (major_id), FOREIGN KEY (zip) REFERENCES zip_code (zip_code));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO event (event_id, event_name) VALUES ('e1', 'Event 1');
INSERT INTO member (member_id) VALUES ('m1');
INSERT INTO member (member_id) VALUES ('m2');
INSERT INTO member (member_id) VALUES ('m3');
INSERT INTO member (member_id) VALUES ('m4');
INSERT INTO member (member_id) VALUES ('m5');
INSERT INTO member (member_id) VALUES ('m6');
INSERT INTO member (member_id) VALUES ('m7');
INSERT INTO member (member_id) VALUES ('m8');
INSERT INTO member (member_id) VALUES ('m9');
INSERT INTO member (member_id) VALUES ('m10');
INSERT INTO member (member_id) VALUES ('m11');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm7');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm8');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm9');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm10');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm11');
INSERT INTO budget (budget_id, category, amount, link_to_event) VALUES ('b1', 'Other', 50, 'e1');
INSERT INTO budget (budget_id, category, amount, link_to_event) VALUES ('b2', 'Other', 50, 'e1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id HAVING COUNT(T2.link_to_event) > 20;

/*
Gold Result:
*/

-- Prediction Query
SELECT e.event_name FROM event AS e JOIN attendance AS a ON e.event_id = a.link_to_event LEFT JOIN budget AS b ON e.event_id = b.link_to_event GROUP BY e.event_id HAVING COUNT(a.link_to_member) > 20 AND (NOT b.category IN ('Food', 'Advertisement') OR b.amount <= 150);

/*
Prediction Result:
('Event 1',)
*/