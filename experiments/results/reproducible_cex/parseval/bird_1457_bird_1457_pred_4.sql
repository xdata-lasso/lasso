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
-- Inserting into table: member --
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__69e889', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 't3__79203d', 't3__e66e79', 'y9uxj4', 'wb', 'v', 't3__c7c9db', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'xb72fxa7r', 'fdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 't3__79203d', 't3__e66e79', 'jpttg', 'bnou5zi36', '4', 't3__c7c9db', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 'xcmr0', 'ztdg', '5i3', 'q5l', 'pim5', '58q', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'wn', 'as6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 't3__79203d', 't3__e66e79', '8ftp6ewtqx', 'njabym', 'n2mfx7h', 't3__c7c9db', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('E', 't3__79203d', 't3__e66e79', 'pe0', '19cy7od033d', 'hds', 't3__c7c9db', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 't3__79203d', 't3__e66e79', '795ybv8', 'kr3w4jn2', '19xgjja', 't3__c7c9db', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 't3__79203d', 't3__e66e79', 'nyj5yrji', 'mqkna38g', 'xs', 't3__c7c9db', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__5fef9d', '8o', '6b', 'p9qgjradfhj', '8zr6k53p8e5o', 'f0y', '1u', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'um5', 'zbuo4nrq', 'rofqyp5s5b');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'rwbbp6luhvd', 179.378884, 304.02808, -1364429300, 'nprmdposii', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__c3c367', 'unw6klfa', 587.783596, 558.971814, 1419861592, '4ecigce376n', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'gndqwnqc', 629.317167, 668.309685, 580968159, 'cprj', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('/', 'bilyrkn', 692.775559, 339.789525, 1784916884, 'ah0f8jsww', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__f5423e', 'ctdctmfg62g0', 935.463334, 492.883123, 820970595, 'qdjpe1io2', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'cl5ams', 665.099697, 270.763563, -605061107, 'gc1d', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('I', 'qlud8', 82.054778, 720.830622, 1183069552, '4qbre6b', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'b7v88kwd', 916.71268, 880.348467, 1671062261, 'h', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('?', 'nlj', 563.529532, 889.753231, 1004962990, 'p61l', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__48bd43', 'kzi0g50j5', 903.625017, 784.191218, 1617485225, 'qcue', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'u0dz7', 'fjgq8n2f3', 687.701166, 'qv0gcb98ozk', 'O', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'itsj3', 'y', 360.694313, 'q4301jh', 'A', '/');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'den8c68x', 'vacx7afu5', 354.593207, 'of77pzo', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', 'foa', 'cd07z2zezjo7', 570.824589, 'xd', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 's27p2r94gth2', 'najj', 185.260952, 'okv8uttm', '?', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', '2ne578', 'fvy', 392.947196, 'zzbe8yvkv', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'pmaus3auvmkr', 'pdjwzw5chn9', 191.1711, '705a', 'O', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', '9n0jxfofwsz', 'o', 778.650393, '2zobb0q0k32o', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'j9erhizgk1', 'yoeyo6l0hdt6', 834.163912, 'qyxuzk', 't1__69e889', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'bindz', '9tajz9td', 535.501742, '5wcgumbc3td', 'G', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', 'u6bd0w9603', 'vzxw1rxe9y', 85.140124, '7qk', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', '162nh55y3d', 'ohvu06dza3', 485.223245, 'mkio1', 'A', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', '6sto', 'cj8sh5k', 207.572242, 'ys7dyyd', '_', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'jmgjach', 'qta8y3a17', 741.721165, '4ygmay', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', '3qdpu', 'p', 552.684299, 'rntdqrhm5', 't1__69e889', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'p490xdmsqt', 'el', 40.211911, 'qb9i9f2ccu', 'O', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', 'jq1', 'uik1y', 680.51123, '0', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', 'hlst1pqom', 'ztv', 17.438617, '4iz7', 'A', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'kjh85wpxl', 'vrisurz0ka', 637.983222, 'tncgc', 'O', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', '6j47n', 'ar50hs', 147.214741, 'n', 'A', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', 'xdpunmw', 'wx', 257.835629, 'awk', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'mg97a', 'z2o20', 974.446302, 'j6dd', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', 'ysu', 'iphdku2gi', 759.141894, '31vwq51oa2sb', '?', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', 'uoi1pavc', 'wnyqro', 973.214347, 'uirlrpouit63', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_25', '26mb', 'aj0ju0h3', 753.62991, '133ir1axyy', 'O', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_26', 'hpl2i9esap', 'pgckqwtsr', 659.070788, '4o6qjekt', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_27', '1', '2', 211.896872, 'g3rjkwn', 't1__69e889', 'I');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_28', 'y', 'vjwq49yr', 736.293094, 'xs6dvdxdo2', 'O', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_29', '7t3gvp', 'j9f', 146.155144, 'uun7k10z2my1', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_30', 'gyv1', 'gezax', 46.864581, 'clupgly', 'A', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_31', 'ed', '9lqv26u3', 460.638735, 'spxpw30bgwkx', 'E', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_32', 'o3ak162o', 'cagjeevxzxlu', 989.611258, '9kuboe8c', 'A', '?');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_33', 'e', 'uekhllbw', 935.082587, 'p', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_34', 'v2z129835', 'oepacx', 62.264038, '2', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_35', '0c', '96xiyet8', 774.266879, 'hcf', '@', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_36', '6cfperxa', '1sjv8nv3d', 59.584068, 'kuez', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'mvb7vpc0xffw', 'r1es', 978.77393, 'f9q82', 'O', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'g01hu', 'j7f', 603.128475, 'qhi', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_39', 'u5gm8gxb5qj', 'saw', 858.731883, '4kwi', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('_', 'ukfb', 'if4180te', 266.308211, 'ok', 'C', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_41', 'ee6slt', 't6lu2c', 63.437766, 'l8mhfcimn5e', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_42', '5oqxs27', 'h888y1', 159.703774, '53sb59ls', 'O', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_43', '1ehn1mdaqq', 'yy', 401.545802, 'p64h', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('Q', 'nnw4', 'm0rrwbjk0b', 245.509819, 'gdwb7jjpl', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_45', 'd0zmxwdb', 'otp5qo1k4', 594.105631, 'gwnkd4kc3', 'I', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_46', 'iikaxzr90nhs', '9gob', 24.973024, 'rn5u', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'phy', 'n', 846.321829, 'y', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_48', 'fs3qn0b', 'm2rlxcrw', 928.340436, '03rzgz', 'O', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_49', '4lqme2wb1', '3', 337.572373, 'n66e0i', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_50', '0o50q833g', '865zm6dpewew', 618.342373, '2p40u2vil', 'G', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_51', '1xsad6q5', 'iqoauy0', 449.887629, 'wh9', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', 'xjqbloxd4', 'j5il9', 811.615432, 'nd6dvygwak', 'O', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_53', 'mwgw73fy3d', 'dip', 671.656078, 'xfbl1', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_54', '5m4s2ajdu', '6xuj90te', 87.844941, 'u5u7709q', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_55', 'uumwu7', 'l', 140.885725, 'jwk6hh2', 'G', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_56', 'oe79350fzrv1', 'l93', 732.145658, '0xvkviql6n', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_57', 'in', 'bciv', 986.237451, 'ojsmeqv3', 'G', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_58', '3uxdo', 'a0ol1z', 734.343754, 'rss', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('/', 'h', '2404qpp33', 410.598937, '1', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_60', 'ojdlhl', 'pdyxk0a', 893.593329, 'q', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_61', 'p', '760ugk2', 120.614868, 'zxp', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_62', 'kjog8dw16f5t', 'hjd5m', 11.060544, 'kr2t', 'O', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_63', 'dlb6i42', 'tew5c29d', 356.196555, 'havc2c4', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_64', 'pw8672f', 've0jf4i5t99k', NULL, 'nbhvi6', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_65', 'p3tfn', 'dtw89qy6sru4', NULL, 'uf', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_66', '48u5lvdb', '3ceh', 390.136935, '3oylciif0l', 'O', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_67', '46upleo', 'h3m3q0pq97j', 631.55198, '534j5xbk11ys', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_68', 'zc7x', 'v4pmp', NULL, 'jve', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_69', '2', 'rn6j7', NULL, '2vkwegrf6snl', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_70', 'ojnhh6', 'a3tdx5', 124.575963, '75b7', 'G', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_71', '3o58zbgy', 'xt0twoua4yi4', 644.398173, '5c', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_72', 'f1q9w43i', 'l', NULL, '8s82sp4j9fo', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_73', 't', 'kcq2iae6a', NULL, '6ql', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_74', 'fxsove9', 'b850235v8', 949.346296, 'kp3', '_', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_75', 'u77cx', 'swgr124vu6v', 534.272506, 'kl', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_76', 'y93zu8y', 'b4qpog5smdhc', NULL, 'tnj8y6whwhl', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_77', '5i', 'dtdjm8r', NULL, 'y9lhw6lv7j45', 't1__69e889', 't1__c3c367');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_78', 'uw42p20gwtf', 'k1', 836.212666, 'bjksuye6', 'O', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_79', 'hvzboodlz60', 'sijufc2vfgh', 874.547795, 'bugxis', 'A', 't1__f5423e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_80', 'q2i', 'dq44u', 654.419597, 'kz', 't1__69e889', 't1__c3c367');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.first_name, T3.last_name, T3.phone FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member WHERE T1.cost > (SELECT AVG(T1.cost) FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member);

/*
Gold Result:
('t3__79203d', 't3__e66e79', 't3__c7c9db')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('wn', 'as6', '9oaawg')
('xcmr0', 'ztdg', '58q')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name, T1.phone FROM member AS T1 JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE T2.cost > (SELECT AVG(cost) FROM expense);

/*
Prediction Result:
('t3__79203d', 't3__e66e79', 't3__c7c9db')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('wn', 'as6', '9oaawg')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('t3__79203d', 't3__e66e79', 't3__c7c9db')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('xcmr0', 'ztdg', '58q')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('t3__79203d', 't3__e66e79', 't3__c7c9db')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('t3__79203d', 't3__e66e79', 't3__c7c9db')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('t3__79203d', 't3__e66e79', 't3__c7c9db')
('t3__79203d', 't3__e66e79', 't3__c7c9db')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('t3__79203d', 't3__e66e79', 't3__c7c9db')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('t3__79203d', 't3__e66e79', 't3__c7c9db')
('wn', 'as6', '9oaawg')
('t3__79203d', 't3__e66e79', 't3__c7c9db')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('wn', 'as6', '9oaawg')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('t3__79203d', 't3__e66e79', 't3__c7c9db')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('t3__79203d', 't3__e66e79', 't3__c7c9db')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
*/