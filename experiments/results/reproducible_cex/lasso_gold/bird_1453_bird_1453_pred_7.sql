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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('particular', 'William Lamb', 'cause', 'face', 'Scientist page travel.', '6637 Jason Street
Brianview, WV 15704', 'so');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('condition', 'Donna Miller', 'power', 'toward', 'Process have compare site.', '7478 Noah Squares Suite 742
Smithmouth, MS 89432', 'effort');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('page', 'Sarah Ramirez', 'fast', 'even', 'Machine son television garden base.', '85694 Nelson Unions
West Destinyfurt, NH 89012', 'similar');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('sit', 'Amanda Thomas', 'consider', 'west', 'Lay color opportunity stand.', 'Unit 9825 Box 3092
DPO AA 08787', 'popular');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('particularly', 'Kaitlin Hardin', 'project', 'food', 'Box organization past as.', '2582 Sanchez Prairie
East Craigfurt, WI 21178', 'role');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('early', 'Michael Anderson', 'apply', 'tend', 'International specific word question food.', '00219 Butler Valley Suite 232
Alexandrachester, IA 23379', 'always');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('remember', 'George Vaughn', 'body', 'have');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('per', 'Joshua Chambers', 'reveal', 'discuss');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('speech', 'Alexandra Davis', 'like', 'share');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('pick', 'Dr. Mark Patton MD', 'sort', 'majority');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('couple', 'David Wilson', 'notice', 'produce');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('series', 'Anna Cox', 'movement', 'receive');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1436, 'federal', 'North Christineton', 'how', 'Tennessee', 'Delaware');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1437, 'enter', 'New Danielle', 'realize', 'Oregon', 'Vermont');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1438, 'data', 'North Melissaberg', 'south', 'Idaho', 'Kentucky');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1454, 'detail', 'Port Edwardfort', 'learn', 'Wisconsin', 'Connecticut');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1455, 'argue', 'Thompsonton', 'good', 'New Jersey', 'West Virginia');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1456, 'daughter', 'Lake Michaelborough', 'practice', 'Arizona', 'Arkansas');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('financial', 'Parking', 1439.5, 1442.5, 1445, 'would', 'particular');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('manage', 'Parking', 1446.5, 1451.5, 1456.0, 'bag', 'particular');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('recent', 'Parking', 1453.5, 1460.5, 1467.0, 'purpose', 'particular');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('wish', 'church', 1457.5, 1460.5, 1463, 'coach', 'sit');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('note', 'church', 1464.5, 1469.5, 1474.0, 'stock', 'sit');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('control', 'church', 1471.5, 1478.5, 1485.0, 'air', 'sit');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('long', 'Kayla', 'Carrillo', 'kimberly66@example.com', 'increase', 'million', '+1-363-391-7410', 1436, 'remember');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('win', 'Heather', 'Scott', 'scottlisa@example.org', 'could', 'boy', '001-647-407-2006', 1436, 'remember');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('factor', 'Elizabeth', 'Norman', 'mjones@example.net', 'quite', 'charge', '001-556-290-8776x618', 1436, 'remember');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('memory', 'Chad', 'Riley', 'jerry15@example.org', 'pay', 'least', '+1-472-265-2735x435', 1454, 'pick');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('myself', 'Joe', 'Barnes', 'youngrobert@example.org', 'arm', 'check', '001-690-442-1776x253', 1454, 'pick');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('business', 'Sean', 'Burgess', 'evance@example.com', 'voice', 'direction', '+1-992-698-3168x7397', 1454, 'pick');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('if', 'Building movement yard four field area young.', 'safe', 1455.5, 'both', 'long', 'financial');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('risk', 'Half table future subject.', 'in', 1457.5, 'professor', 'long', 'financial');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('television', 'Possible computer always his course.', 'war', 1459.5, 'her', 'long', 'financial');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('message', 'Just country along agent you draw home society.', 'low', 1451.5, 'truth', 'long', 'financial');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('become', 'Matter who speech whom administration.', 'yard', 1460.5, 'two', 'long', 'financial');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('value', 'Argue skin amount brother southern project.', 'resource', 1469.5, 'not', 'long', 'financial');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('address', 'Easy its develop until watch.', 'actually', 1473.5, 'investment', 'memory', 'wish');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('show', 'Together individual analysis yard safe mean international.', 'room', 1475.5, 'discover', 'memory', 'wish');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('later', 'Look something start laugh drive next.', 'sign', 1477.5, 'find', 'memory', 'wish');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('edge', 'Look fight reflect.', 'nice', 1469.5, 'last', 'memory', 'wish');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('raise', 'Section agency lawyer sign them if smile.', 'alone', 1478.5, 'soldier', 'memory', 'wish');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('believe', 'Phone region ability physical his real.', 'fine', 1487.5, 'expect', 'memory', 'wish');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense);

/*
Gold Result:
('William Lamb',)
('William Lamb',)
('William Lamb',)
('William Lamb',)
('William Lamb',)
*/

-- Prediction Query
SELECT T1.event_name FROM event AS T1 JOIN budget AS T2 ON T1.event_id = T2.link_to_event JOIN expense AS T3 ON T3.link_to_budget = T2.budget_id WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense WHERE link_to_budget IN (SELECT budget_id FROM budget WHERE category = 'Parking'));

/*
Prediction Result:
('William Lamb',)
('William Lamb',)
('William Lamb',)
*/