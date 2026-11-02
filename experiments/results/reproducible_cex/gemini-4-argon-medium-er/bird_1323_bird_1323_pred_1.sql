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
INSERT INTO event (event_id, event_name) VALUES ('1', 'Big Event');
INSERT INTO member (member_id) VALUES ('1');
INSERT INTO member (member_id) VALUES ('2');
INSERT INTO member (member_id) VALUES ('3');
INSERT INTO member (member_id) VALUES ('4');
INSERT INTO member (member_id) VALUES ('5');
INSERT INTO member (member_id) VALUES ('6');
INSERT INTO member (member_id) VALUES ('7');
INSERT INTO member (member_id) VALUES ('8');
INSERT INTO member (member_id) VALUES ('9');
INSERT INTO member (member_id) VALUES ('10');
INSERT INTO member (member_id) VALUES ('11');
INSERT INTO member (member_id) VALUES ('12');
INSERT INTO member (member_id) VALUES ('13');
INSERT INTO member (member_id) VALUES ('14');
INSERT INTO member (member_id) VALUES ('15');
INSERT INTO member (member_id) VALUES ('16');
INSERT INTO member (member_id) VALUES ('17');
INSERT INTO member (member_id) VALUES ('18');
INSERT INTO member (member_id) VALUES ('19');
INSERT INTO member (member_id) VALUES ('20');
INSERT INTO member (member_id) VALUES ('21');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '7');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '8');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '9');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '10');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '11');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '12');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '13');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '14');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '15');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '16');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '17');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '18');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '19');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '20');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('1', '21');
INSERT INTO income (income_id, link_to_member) VALUES ('inc1', '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id HAVING COUNT(T2.link_to_event) > 20;

/*
Gold Result:
('Big Event',)
*/

-- Prediction Query
SELECT e.event_name FROM event AS e JOIN attendance AS a ON e.event_id = a.link_to_event LEFT JOIN income AS i ON e.event_id = i.link_to_member GROUP BY e.event_id, e.event_name HAVING COUNT(a.link_to_member) > 20 AND i.income_id IS NULL;

/*
Prediction Result:
*/