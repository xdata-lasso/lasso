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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('although', 'Evelyn Garcia', 'clear', 'station', 'Realize power system system teacher here first responsibility.', '45562 Amanda Port Apt. 221
Harveybury, NM 76936', 'if');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('card', 'Ariana Lozano', 'bad', 'evidence', 'Their along attention piece TV young section.', '474 Rachel Mountain Suite 821
Landryshire, ME 84247', 'tonight');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('morning', 'Charles Pitts', 'manager', 'ground', 'Within set region beyond coach federal.', 'USNV Bryant
FPO AA 26612', 'meeting');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('house', 'Andrea Decker', 'or', 'can', 'Test return why outside goal official.', 'Unit 9980 Box 9402
DPO AA 92605', 'dinner');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('claim', 'Brent Rodgers', 'girl', 'item', 'Choice lot suggest glass news.', '0229 Jones Streets Apt. 183
Barnesmouth, GA 49004', 'someone');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('right', 'Kristie Willis', 'religious', 'health', 'Several off southern suddenly.', '910 Eric River Apt. 147
Tuckermouth, MT 36305', 'music');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('benefit', 'Stacey Arias', 'from', 'those', 'Social case expert stop receive catch.', '808 Jennifer Highway Suite 095
New Robert, TN 88085', 'measure');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('your', 'James Brooks', 'word', 'send', 'Large accept bad eight strong nature road.', '88888 Peter Mountains Apt. 654
West Kristinastad, IA 96569', 'program');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('doctor', 'Brad Walker', 'bit', 'rate', 'Institution simply down business draw police performance.', '520 Payne Via
Port Kimberly, NH 91647', 'court');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('both', 'Laura Haney', 'size', 'police');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('economic', 'William Barrett', 'appear', 'skill');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('I', 'Keith Jennings', 'whether', 'model');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('build', 'Michael Watkins', 'speak', 'figure');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('hair', 'Elizabeth Walker', 'certain', 'generation');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('law', 'Mrs. Christine Dougherty', 'south', 'call');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('talk', 'Terri Johnson', 'teacher', 'environment');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('central', 'Rick Blackwell', 'of', 'some');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('at', 'Eric Sanders', 'material', 'radio');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1082, 'there', 'Kimberlybury', 'production', 'Tennessee', 'New Hampshire');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1083, 'well', 'Jefferyborough', 'bill', 'Arizona', 'Pennsylvania');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1084, 'weight', 'Ericaberg', 'product', 'Maryland', 'Mississippi');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1109, 'account', 'Thompsonfurt', 'least', 'California', 'Nevada');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1110, 'modern', 'New Angelica', 'after', 'Massachusetts', 'Montana');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1111, 'skin', 'Charleston', 'machine', 'Oregon', 'Virginia');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1136, 'cut', 'Port Dianaview', 'group', 'New York', 'Colorado');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1137, 'feeling', 'Port Michealfurt', 'culture', 'North Dakota', 'Washington');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1138, 'heavy', 'Klinefurt', 'role', 'Louisiana', 'Rhode Island');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('sign', 'where', 1085.5, 1088.5, 1091, 'small', 'although');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('catch', 'find', 1092.5, 1097.5, 1102.0, 'just', 'although');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('believe', 'general', 1099.5, 1106.5, 1113.0, 'continue', 'although');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('deep', 'notice', 1094.5, 1097.5, 1100, 'nice', 'although');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('cause', 'under', 1101.5, 1106.5, 1111.0, 'more', 'although');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('stop', 'history', 1108.5, 1115.5, 1122.0, 'white', 'although');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('push', 'interview', 1112.5, 1115.5, 1118, 'Congress', 'house');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('key', 'against', 1119.5, 1124.5, 1129.0, 'suddenly', 'house');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('building', 'garden', 1126.5, 1133.5, 1140.0, 'yourself', 'house');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('prepare', 'road', 1121.5, 1124.5, 1127, 'behavior', 'house');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('magazine', 'wide', 1128.5, 1133.5, 1138.0, 'leave', 'house');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('theory', 'high', 1135.5, 1142.5, 1149.0, 'three', 'house');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('test', 'finally', 1139.5, 1142.5, 1145, 'base', 'benefit');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('couple', 'full', 1146.5, 1151.5, 1156.0, 'recent', 'benefit');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('offer', 'board', 1153.5, 1160.5, 1167.0, 'follow', 'benefit');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('like', 'last', 1148.5, 1151.5, 1154, 'likely', 'benefit');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('player', 'compare', 1155.5, 1160.5, 1165.0, 'and', 'benefit');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('series', 'have', 1162.5, 1169.5, 1176.0, 'short', 'benefit');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('explain', 'Jonathan', 'Drake', 'mcdonaldcharles@example.org', 'not', 'home', '+1-349-965-1370x98593', 1082, 'both');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('then', 'Makayla', 'Francis', 'zcoffey@example.net', 'candidate', 'remember', '001-446-812-0047x113', 1082, 'both');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('community', 'Timothy', 'Morgan', 'christopher60@example.com', 'look', 'smile', '258.769.2617x964', 1082, 'both');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('director', 'Stephanie', 'Jennings', 'bruce43@example.org', 'other', 'themselves', '493.435.2904', 1082, 'both');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('life', 'Melissa', 'Stephens', 'ndavis@example.net', 'describe', 'southern', '+1-742-210-2053', 1082, 'both');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('light', 'Cory', 'Levine', 'williamsmatthew@example.org', 'authority', 'once', '(940)726-8117', 1082, 'both');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('born', 'Richard', 'Reese', 'dixondaniel@example.net', 'consumer', 'song', '(777)499-7995', 1109, 'build');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('either', 'Christian', 'Walker', 'rebeccabailey@example.net', 'play', 'reality', '917.974.4905x814', 1109, 'build');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('perform', 'Monica', 'Maxwell', 'joelthomas@example.org', 'soon', 'bag', '8059411998', 1109, 'build');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('partner', 'Paula', 'Pearson', 'susanhayes@example.com', 'poor', 'hotel', '(465)790-5151x8644', 1109, 'build');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('strong', 'Shannon', 'Morris', 'wagnergerald@example.org', 'cold', 'whose', '692-854-6291', 1109, 'build');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('single', 'Lisa', 'Alvarez', 'hritter@example.net', 'himself', 'fear', '+1-752-981-6850x5423', 1109, 'build');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('true', 'Christina', 'Moody', 'zcox@example.net', 'start', 'identify', '+1-727-655-7192x856', 1136, 'talk');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('which', 'Ryan', 'Brown', 'stephaniethomas@example.net', 'quite', 'our', '610.627.8681', 1136, 'talk');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('head', 'Danielle', 'Lambert', 'ejohnson@example.org', 'hit', 'alone', '001-973-394-7312x172', 1136, 'talk');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('take', 'Valerie', 'Pierce', 'jenniferho@example.net', 'agree', 'manage', '(891)314-6786', 1136, 'talk');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('rest', 'Elizabeth', 'Roberts', 'laurahicks@example.org', 'herself', 'suggest', '(451)477-8528', 1136, 'talk');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('through', 'Jenna', 'Evans', 'laurayoung@example.com', 'page', 'ok', '(380)618-2422x53584', 1136, 'talk');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('must', 'Mean war analysis situation term miss leader.', 'political', 1110.5, 'face', 'explain', 'sign');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('personal', 'Article look husband.', 'choose', 1112.5, 'probably', 'explain', 'sign');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('boy', 'Make travel available ball.', 'attorney', 1114.5, 'property', 'explain', 'sign');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('pay', 'Herself our far measure involve soldier.', 'show', 1106.5, 'late', 'director', 'deep');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('official', 'Table prepare shoulder result.', 'beyond', 1115.5, 'reduce', 'director', 'deep');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('seem', 'Involve thousand including still human.', 'form', 1124.5, 'especially', 'director', 'deep');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('dark', 'Such big side strong this.', 'require', NULL, 'popular', 'born', 'push');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('draw', 'Product then peace.', 'serve', NULL, 'feel', 'born', 'push');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('bank', 'Heavy class story side speak close join improve.', 'economy', NULL, 'soldier', 'born', 'push');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('step', 'Dream whole six tough create question now.', 'because', NULL, 'listen', 'partner', 'prepare');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('list', 'Left example high month whom stage.', 'source', NULL, 'western', 'partner', 'prepare');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('east', 'Catch economic political them never bill suffer surface.', 'college', NULL, 'choice', 'partner', 'prepare');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('debate', 'Field move maybe collection walk child probably result.', 'quality', 1164.5, 'support', 'true', 'test');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('prove', 'Front under American tell ball we side enough.', 'five', 1166.5, 'surface', 'true', 'test');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('car', 'Short indicate police marriage phone.', 'election', 1168.5, 'reveal', 'true', 'test');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('into', 'Read citizen indeed less.', 'example', 1160.5, 'apply', 'take', 'like');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('finish', 'Parent fine responsibility safe team wish.', 'end', 1169.5, 'fill', 'take', 'like');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('long', 'Set middle blood drop.', 'chance', 1178.5, 'young', 'take', 'like');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('treat', 'Mean war analysis situation term miss leader.', 'political', NULL, 'face', 'explain', 'sign');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.first_name, T3.last_name, T3.phone FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member WHERE T1.cost > (SELECT AVG(T1.cost) FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member);

/*
Gold Result:
('Christina', 'Moody', '+1-727-655-7192x856')
('Valerie', 'Pierce', '(891)314-6786')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name, T1.phone FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name, T1.phone HAVING SUM(T2.cost) > (SELECT AVG(cost) FROM expense);

/*
Prediction Result:
('Christina', 'Moody', '+1-727-655-7192x856')
('Jonathan', 'Drake', '+1-349-965-1370x98593')
('Stephanie', 'Jennings', '493.435.2904')
('Valerie', 'Pierce', '(891)314-6786')
*/