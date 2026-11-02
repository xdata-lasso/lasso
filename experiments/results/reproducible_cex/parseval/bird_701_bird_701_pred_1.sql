-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: posts --
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, 1274489983, -1683203397, '2025-04-19 21:11:20+00:00', -1833165707, 1155439218, 'um5', 1, '2023-11-07 12:14:47+00:00', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, -868774469, -2147483648, '2021-03-04 19:22:02+00:00', '2022-02-19 15:51:21+00:00', -2118135981, '2023-08-19 04:29:46+00:00', 'yytoo', 'o9hl72kl');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, -1929953647, 1581736075, '2023-09-26 13:08:37+00:00', 50, 1298861365, 'q', 1, '2022-12-08 23:34:02+00:00', 'qcx5', 'hncprjtu0dz', -1748371085, -1742081330, 894242932, -2147483648, '2023-11-01 15:52:25+00:00', '2020-10-05 05:32:26+00:00', -1056308489, '2023-06-17 22:27:46+00:00', 'gcb98ozk3z', 'i');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, -1173368267, 382831862, '2020-07-08 07:50:44+00:00', 2115816682, 76987628, 'zezjo7wg', 4, '2023-03-07 00:15:11+00:00', '5', 'sxcmr0o', 853709925, -870767087, -1699185893, 2, '2025-12-26 14:53:02+00:00', '2024-03-18 21:27:42+00:00', -1609653472, '2021-06-20 20:52:42+00:00', '5lnpi', '5k58');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, 756202403, 782684333, '2024-01-18 21:37:49+00:00', -1122409769, 1849819405, 'us3auvmkrpdj', 4, '2025-10-04 15:32:15+00:00', 'zw5chn', 'mo705a9n0', 1731843275, -582376271, -1165594842, -2147483646, '2022-12-30 09:36:03+00:00', '2022-07-09 16:59:45+00:00', 1719800120, '2020-06-20 19:03:43+00:00', '2zob', '0');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, 1048147204, -1814875250, '2022-12-20 18:28:11+00:00', -1589605308, -268740517, 'nxih662q', 4, '2023-10-18 11:51:31+00:00', 'lyotow', 'oaawg96aq', -2061634386, -850941333, -1216952047, -2147483646, '2023-05-07 05:01:37+00:00', '2023-12-20 17:13:08+00:00', -2140923099, '2023-05-09 01:10:53+00:00', 'td8n5wcgu', 'bc3t');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 431832073, 1510892261, '2020-12-31 16:25:14+00:00', 389700824, -1853955201, 'qxxnj', 1, '2020-01-09 12:53:38+00:00', 'bymzn2mfx7h3', 'p6sto1cj', 1728926031, -63214972, 1106724223, 2, '2025-06-29 15:21:32+00:00', '2023-03-26 14:26:48+00:00', 1487347213, '2023-03-15 00:23:20+00:00', 'yd1jmgjach8', 'qta8y3a17v4y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -2081662466, -1941472821, '2025-06-16 07:53:05+00:00', -2082238979, -845136979, 'rhm5w', 1, '2021-07-17 00:45:37+00:00', 'c7d', 'n2np490xdms', -1027584872, -1685482179, -1391541536, 1, '2022-09-26 08:18:54+00:00', '2025-02-01 17:53:54+00:00', -1025517017, '2024-09-18 21:46:55+00:00', 'i9f2ccukjq1q', 'ik1yhb');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -1964997180, 1149850321, '2020-05-18 19:45:10+00:00', 50, 528680845, '76nium52', 3, '2025-09-21 09:36:38+00:00', 'buo4nrq', 'rofqyp5s5b', 2107872094, 882961052, 743312762, -2147483639, '2024-11-25 22:27:17+00:00', '2020-08-22 17:31:36+00:00', -751275471, '2021-08-01 11:21:15+00:00', 'qa1', 'ryytoo3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -1964997180, 1149850321, '2020-05-18 19:45:10+00:00', 50, 528680845, '76nium52', 5, '2025-09-21 09:36:38+00:00', 'buo4nrq', 'rofqyp5s5b', 2107872094, 882961052, 743312762, -2147483639, '2024-11-25 22:27:17+00:00', '2020-08-22 17:31:36+00:00', -751275471, '2021-08-01 11:21:15+00:00', 'qa1', 'ryytoo3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 401805964, -1485777725, '2022-03-23 04:34:16+00:00', 50, 894242932, 'f3dqv0gc', 6, '2020-04-02 07:45:47+00:00', '8ozk3zbil', 'yrkn6vck6ah0', -1520489792, -658391922, -1388029300, -2147483632, '2024-06-08 00:23:27+00:00', '2023-02-17 08:54:45+00:00', -541746689, '2024-12-20 11:42:02+00:00', 'ryfdrz16n', 'jja');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 1897687032, -241848752, '2024-05-29 05:19:47+00:00', 50, 199672698, '7cvtjpt', 7, '2025-02-24 17:48:00+00:00', 'g6bno', '5zi36c', 1722106924, -2072838897, -1173368267, 2, '2025-01-04 09:05:19+00:00', '2020-05-22 14:53:50+00:00', -406331049, '2023-05-04 15:58:08+00:00', 'zj', '7wgx');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, -929383517, -2090240067, '2022-11-13 09:18:31+00:00', 50, -1278087274, 'rpdjwzw5ch', 8, '2021-10-23 07:09:38+00:00', 'mo705a9n0', 'xfo', -1793230843, -441521858, 2015094998, -2147483648, '2023-11-02 10:05:42+00:00', '2023-05-26 04:07:05+00:00', 270415200, '2020-02-24 22:37:14+00:00', '0', '0k32o');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 1083479253, 1774679448, '2024-08-29 05:28:03+00:00', 50, 727608179, 'awg96aqb0tbi', 9, '2025-04-01 08:16:25+00:00', 'dz39', 'ajz9t', 748154000, 1148916014, -1988582944, -2147483639, '2022-09-05 12:39:02+00:00', '2021-09-22 22:06:25+00:00', 989306270, '2025-03-26 09:37:26+00:00', 'tdu6bd0w96', '3vzxw1r');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, -515419519, -1884062674, '2025-09-13 12:59:23+00:00', 50, 1328948152, '1', 10, '2024-12-17 00:18:59+00:00', 'mgj', 'c', 973811121, 280292620, 620355627, -2147483642, '2025-04-13 01:34:03+00:00', '2024-08-25 18:28:13+00:00', 1122899168, '2023-12-07 21:40:21+00:00', '1', 'v4ygmayq3');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, 1, '2024-12-15 00:56:33+00:00', '5k5swwqcgsk9', '2021-10-04 22:30:57+00:00', '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', 13244799, -1659388584, 1526238907, -1377057208, -841692980, 'bnp');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, 1, '2022-04-12 01:47:28+00:00', 'dpos', '2021-02-17 05:47:13+00:00', 'e5u', 'w6kl', 'a9', 1620389964, 546571701, 947159877, 1990080517, 1408123494, '4');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483646, 1, '2020-08-18 16:30:34+00:00', 'x14ji7zwau2d', '2023-01-13 04:58:30+00:00', 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 556727997, 1178000634, 1836127587, -1529584866, 1196308825, 'd21vy9uxj4hw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483645, 1, '2021-07-02 01:45:48+00:00', 'yrkn6vck6ah0', '2020-10-15 18:29:15+00:00', 'jswwlq7xb', '72fxa7ryfd', 'z16ni', 2011234363, -1483100200, -7597509, -1625552518, -1738458256, 'jd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1, '2024-07-26 15:42:53+00:00', 'yzt1afgogrit', '2025-08-05 22:21:48+00:00', 'j3ayx', '1q43', '1jh3den', 357330522, -683007527, 2035306060, 1523825314, 2078438287, '5w1of7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -1099855564, '2021-11-28 21:12:32+00:00', '72ctdctmfg62', '2020-10-18 11:14:36+00:00', 'v5q8qdj', 'e1io', '278507cv', -866772222, -847293924, -2033879835, 1798111945, 944975670, 'i36c4bf');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483642, 1, '2022-02-21 20:00:53+00:00', 's27p2r94gth2', '2021-08-24 18:58:08+00:00', 'ajjl', '3', 'okv8uttmu2', -1252009958, 1908593332, 697257217, -451030047, -2052653308, 'yvkv42q7s');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483641, 1, '2022-03-19 07:41:34+00:00', '0k32odwcl5a', '2025-04-19 10:34:51+00:00', 'msorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', -1614619556, 1435223075, 1617348603, -477129795, -1418927432, '521gwnlas6e');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483640, 1, '2020-07-01 00:06:39+00:00', 'u6bd0w9603', '2025-01-19 15:40:16+00:00', 'vzxw1rxe9yf', '7qk', '162nh55y3d', 440797047, -732999244, 1654100852, 30861410, -438741674, '5rmkio18');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483639, 1, '2023-07-12 04:15:18+00:00', 'hlst1pqom', '2021-03-09 19:03:35+00:00', 'tvb6m4i', '78aqqlu', '8', 948460309, 1183069552, -1057355067, -1004098188, 316163741, 'uu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483638, 1, '2021-04-16 22:22:11+00:00', 'kjh85wpxl', '2025-04-06 16:59:59+00:00', 'risurz', 'kaqtncg', 'c8s3b7v88k', -622923312, 1789767331, 1633584225, 1671062261, -1924635316, '6j47n');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 1, '2024-12-15 00:56:33+00:00', '5k5swwqcgsk9', '2021-10-04 22:30:57+00:00', '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', 13244799, -1659388584, 1526238907, -1377057208, -841692980, 'bnp');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483636, 1, '2022-04-12 01:47:28+00:00', 'dpos', '2021-02-17 05:47:13+00:00', 'e5u', 'w6kl', 'a9', 1620389964, 546571701, 947159877, 1990080517, 1408123494, '4');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1, '2024-12-15 00:56:33+00:00', '5k5swwqcgsk9', '2021-10-04 22:30:57+00:00', '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', 13244799, -1659388584, 1526238907, -1377057208, -841692980, 'bnp');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483634, 1, '2022-04-12 01:47:28+00:00', 'dpos', '2021-02-17 05:47:13+00:00', 'e5u', 'w6kl', 'a9', 1620389964, 546571701, 947159877, 1990080517, 1408123494, '4');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1, '2021-12-11 04:26:48+00:00', 'hl72klex1', '2024-02-08 07:13:40+00:00', 'i7z', 'au2dwy', 'q13py', 244829661, -1362461264, -904834265, -346339240, 1692174491, 'qi2rkf9v');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483632, 1, '2022-03-30 02:18:34+00:00', 'x58pz0f8je', '2020-10-30 07:33:08+00:00', 'd21vy9uxj4hw', 'd', 'lph2gn', 1968874827, -664193365, -1070063173, 555413010, 722884590, 'hncprjtu0dz');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2021-02-04 08:22:25+00:00', 'dh5ogrgj', '2020-06-19 19:37:13+00:00', 'yzt1afgog', 'itsj3', 'y', -598313376, 1972233925, 1792827279, 804529642, -1538707438, 'den8c68x');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483630, 1, '2024-08-13 21:17:54+00:00', 'acx7af', '2022-09-01 11:41:59+00:00', 'w1of77pz', '72ct', 'c', 1303877941, -1284905200, 7929158, -1744557630, 1870300798, 'q8qdjpe1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1, '2020-06-06 19:46:47+00:00', 'ysxcmr0o', '2025-12-11 00:03:18+00:00', 'tdgj5i3', 'q5l', 'pim5', -1125548818, 1497321728, -95808609, -244633520, 418247369, 'jla');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483628, 1, '2023-12-07 12:32:22+00:00', 'okv8uttmu2', '2021-10-09 18:25:05+00:00', '57', 'lfvyz7zzb', '8y', -705922211, 1043710187, 318331233, -233617564, 79330142, '58b4pm');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1, '2020-06-28 23:31:51+00:00', 'cl5ams', '2025-08-28 09:25:40+00:00', 'rlwy', 'gc1d', 'j9erhizgk1', 955267863, -1156828895, 1483450542, 513375398, 718167481, 'hdt6fuq');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483626, 1, '2023-04-23 07:11:55+00:00', 'uzkb52', '2023-09-14 18:35:43+00:00', 'wn', 'as6', 'elboeowii1', -457369423, 1557188093, 548968280, -1552469358, 7342822, '2xlyo');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1, '2023-03-02 21:11:27+00:00', '9y', '2020-09-21 12:30:27+00:00', '7qk', '162nh55y3d', 'ohvu06dza3', 1595632888, 2072023304, 789756515, -1160642134, 769234989, '8ftp6ewtqx');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483624, 1, '2023-01-28 06:02:52+00:00', 'jaby', '2025-03-02 19:27:14+00:00', 'zn2m', 'x7', '33', 1220047834, 63063873, -843082635, -285085577, 170892881, '5k');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.Score >= 50 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN (SELECT MAX(Reputation) AS max_reputation FROM users) AS T3 ON T1.Reputation = T3.max_reputation;

/*
Gold Result:
(81.81818181818181,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.Score > 50 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.Id) AS percentage FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE NOT T2.Score IS NULL GROUP BY T1.Id ORDER BY T1.Reputation DESC, percentage NULLS LAST LIMIT 1;

/*
Prediction Result:
(0.0,)
*/