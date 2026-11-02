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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Maya26', NULL, 'Maya36', 'Mclean37', 'Maya38', 'Mclean39', 'Maya40');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Mclean25', 'Maya26', 'Maya26', 'Maya26', 'Maya26', 'Maya26', 'Maya26');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Mclean43', 'Maya26', 'Maya26', 'Maya26');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Maya50', 'Maya26', 'Maya26', 'Maya26');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (44, 'Maya26', 'Maya26', 'Maya26', 'Maya26', 'Maya26');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (51, 'Maya26', 'Maya26', 'Maya26', 'Maya26', 'Maya26');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Maya26', 'Mclean49');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Maya26', 'Maya56');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Maya28', 'Mclean25', 'Maya26', 26, 26, 26, 'Maya26');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Mclean27', 'Mclean25', 'Maya26', 26, 26, 26, 'Maya26');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Maya30', 'Mclean27', 'Maya56', 'Maya26', 'Maya26', 26, 'Maya26');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Mclean29', 'Mclean27', 'Maya56', 'Maya26', 'Maya26', 26, 'Maya26');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Maya26', 'Maya56', 'Maya26', 26, 'Maya26', 'Maya26');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Mclean49', 'Mclean43', 44, 'Maya', 'Mclean', 'Mclean45', 'Maya46', 'Mclean47', 'Maya48');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Maya56', 'Maya50', 51, 'Maya', 'Mclean', 'Maya52', 'Mclean53', 'Maya54', 'Mclean55');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T3.first_name = 'Maya' AND T3.last_name = 'Mclean';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT e.event_name FROM member AS m INNER JOIN attendance AS a ON m.member_id = a.link_to_member INNER JOIN event AS e ON a.link_to_event = e.event_id WHERE m.first_name = 'Maya' AND m.last_name = 'Mclean';

/*
Prediction Result:
(None,)
*/