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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('as', 'Mr. James May II', 'stop', 'near', 'Seek director run garden day.', '02321 Brittany Village
East William, NE 95526', 'physical');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('certain', 'Virginia Wallace', 'soon', 'strong', 'Trade professor eat.', '336 Catherine Hollow
Barbaraborough, KY 63569', 'note');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('house', 'Brandy Stewart', 'among', 'join', 'Part high focus kind accept.', '6277 Wagner Street Suite 270
Simmonsland, WV 39852', 'claim');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('follow', 'Joseph Graves PhD', 'hair', 'resource', 'Organization support local camera act message choice.', '6834 Stacey Lodge Suite 111
North Frederick, AR 11587', 'enjoy');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('per', 'Lisa Mosley', 'sure', 'story', 'Central nothing environment truth.', '68277 Richard Ridges Apt. 068
Johnhaven, TX 80349', 'theory');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('surface', 'Travis Price', 'site', 'night', 'Religious eat participant religious consumer worry.', '83215 Willie Center Suite 762
Taramouth, PW 89507', 'notice');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('on', 'John Chavez', 'customer', 'training');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('short', 'Larry Jones', 'above', 'month');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('continue', 'John Moore', 'add', 'show');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('today', 'John Baker', 'myself', 'also');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('toward', 'Mark Long', 'that', 'major');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('buy', 'Tanya Haley', 'walk', 'wait');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1656, 'share', 'Bentleystad', 'image', 'Hawaii', 'Nevada');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1657, 'million', 'Burnsshire', 'work', 'Illinois', 'Kentucky');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1658, 'interview', 'South Nicoleville', 'others', 'Wisconsin', 'Wyoming');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1710, 'prepare', 'Adammouth', 'interest', 'New York', 'North Carolina');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1711, 'method', 'Kennethville', 'hear', 'Colorado', 'Georgia');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1712, 'art', 'West Pamelaburgh', 'act', 'North Dakota', 'Nebraska');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('white', 'happen', 1659.5, 1662.5, 1665, 'middle', 'as');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('society', 'Mr', 1666.5, 1671.5, 1676.0, 'prove', 'as');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('seven', 'security', 1673.5, 1680.5, 1687.0, 'risk', 'as');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('home', 'rather', 1668.5, 1671.5, 1674, 'simply', 'as');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('same', 'with', 1675.5, 1680.5, 1685.0, 'employee', 'as');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('article', 'language', 1682.5, 1689.5, 1696.0, 'eight', 'as');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('account', 'realize', 1713.5, 1716.5, 1719, 'many', 'follow');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('clearly', 'enough', 1720.5, 1725.5, 1730.0, 'indicate', 'follow');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('specific', 'draw', 1727.5, 1734.5, 1741.0, 'his', 'follow');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('later', 'task', 1722.5, 1725.5, 1728, 'leg', 'follow');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('court', 'exist', 1729.5, 1734.5, 1739.0, 'those', 'follow');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('not', 'boy', 1736.5, 1743.5, 1750.0, 'challenge', 'follow');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('mean', 'Lisa', 'Terry', 'jblackburn@example.com', 'whom', 'seat', '883-662-6448', 1656, 'on');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('already', 'Crystal', 'Brewer', 'carrielynn@example.org', 'if', 'peace', '001-961-219-5243x6402', 1656, 'on');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('will', 'Erica', 'Green', 'wilsonchristopher@example.net', 'information', 'wear', '716-486-4622', 1656, 'on');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('score', 'Tom', 'Bradley', 'lisalee@example.com', 'factor', 'all', '871.600.4090x1380', 1656, 'on');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('center', 'Wayne', 'Lewis', 'nsims@example.org', 'attack', 'pay', '275.796.5555x3566', 1656, 'on');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('decade', 'Daniel', 'Harris', 'christophermiller@example.org', 'guess', 'easy', '910-876-2091x84357', 1656, 'on');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('health', 'Michael', 'Lopez', 'rachel23@example.com', 'more', 'improve', '702-825-8030', 1710, 'today');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('small', 'Monica', 'Williams', 'david78@example.com', 'she', 'catch', '+1-406-574-4716x392', 1710, 'today');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('accept', 'James', 'Foster', 'markduran@example.com', 'threat', 'break', '414-536-3718x923', 1710, 'today');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('camera', 'Benjamin', 'Simmons', 'jamesalicia@example.net', 'himself', 'seek', '6203005347', 1710, 'today');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('cause', 'Veronica', 'Jensen', 'jeffreysimmons@example.org', 'yes', 'kid', '(724)775-5411x08255', 1710, 'today');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('institution', 'Sarah', 'Davis', 'tschneider@example.org', 'have', 'front', '343.296.1129', 1710, 'today');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('recent', 'Admit growth animal space for know.', 'nature', 1684.5, 'still', 'mean', 'white');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('cup', 'Machine school soldier give voice walk live probably.', 'under', 1686.5, 'tough', 'mean', 'white');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('about', 'Safe family crime century.', 'owner', 1688.5, 'sense', 'mean', 'white');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('mother', 'Someone feeling pull nature themselves collection land.', 'general', 1680.5, 'space', 'score', 'home');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('almost', 'Lot music during color.', 'weight', 1689.5, 'fast', 'score', 'home');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('care', 'Black year ahead upon.', 'identify', 1698.5, 'discussion', 'score', 'home');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('usually', 'Relate understand avoid national garden.', 'word', 1738.5, 'compare', 'health', NULL);
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('television', 'Writer dark result analysis court nearly education.', 'most', 1740.5, 'place', 'health', NULL);
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('cut', 'Window thus large response treat attack industry.', 'street', 1742.5, 'eye', 'health', NULL);
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('carry', 'Article win couple sport manager mouth message.', 'without', 1734.5, 'second', 'camera', NULL);
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('figure', 'Close seek his single.', 'must', 1743.5, 'service', 'camera', NULL);
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('answer', 'Parent deal about occur option across.', 'lose', 1752.5, 'network', 'camera', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.first_name, T3.last_name, T3.phone FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member WHERE T1.cost > (SELECT AVG(T1.cost) FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member);

/*
Gold Result:
('Lisa', 'Terry', '883-662-6448')
('Tom', 'Bradley', '871.600.4090x1380')
*/

-- Prediction Query
SELECT DISTINCT m.first_name, m.last_name, m.phone FROM expense AS e INNER JOIN member AS m ON e.link_to_member = m.member_id WHERE e.cost > (SELECT AVG(cost) FROM expense);

/*
Prediction Result:
('Michael', 'Lopez', '702-825-8030')
('Benjamin', 'Simmons', '6203005347')
*/