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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, -1910425938, -845863578, '2021-01-23 18:11:33+00:00', -1364429300, -1257178728, 'mdpos', 1, '2021-02-17 05:47:13+00:00', 'e5u', 'w6kl', 1620389964, 546571701, 947159877, 1, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', -1964997180, '2025-03-10 20:24:26+00:00', 'ce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 2103044118, -1642259219, '2020-12-04 21:49:29+00:00', -1264842910, -1052964641, 'qcx5', 1, '2025-05-27 16:57:17+00:00', 'nc', 'rjtu', -361507387, 401805964, -1485777725, 1, '2022-03-23 04:34:16+00:00', '2024-08-10 07:57:32+00:00', -1255130038, '2020-10-05 05:32:26+00:00', 'dqv0gcb9', 'ozk3zbily');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 1038566008, 32204797, '2020-04-16 10:31:38+00:00', 1784916884, 37673509, 'h0f8jswwlq', 1, '2024-06-08 00:23:27+00:00', 'xb72fxa7ryfd', 'z16ni', 2011234363, -1483100200, -7597509, 3, '2025-07-17 09:46:47+00:00', '2021-01-12 13:18:15+00:00', 1583472758, '2020-10-22 21:08:07+00:00', 'gjd8y', 't1afgog');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -902895762, -197933860, '2023-04-12 14:06:32+00:00', -598313376, 1972233925, '4301j', 1, '2021-01-17 17:19:55+00:00', 'den8c68x', 'vacx7afu5', -290314193, 76996700, -435350511, 4, '2025-11-10 20:25:30+00:00', '2025-12-23 18:43:58+00:00', 87529806, '2020-05-17 14:21:08+00:00', 'dctmf', '62');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, -698610044, -1021978385, '2025-05-19 01:18:37+00:00', -1488156735, -1858644047, 'o22', 1, '2024-05-29 05:19:47+00:00', '507cvtjpt', 'tg6bnou5zi', 1944978593, 1722106924, -2072838897, 1, '2021-05-31 16:00:51+00:00', '2020-10-11 01:34:34+00:00', 1923659053, '2020-02-08 07:26:28+00:00', 'cd07z2zezjo7', 'wgxd5ysxcm');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, 983324983, 1269522000, '2025-12-11 00:03:18+00:00', -405743609, -1935752926, '5i3', 1, '2021-06-20 20:52:42+00:00', '5lnpi', '5k58', -1125548818, 1497321728, -95808609, 3, '2022-08-10 04:39:07+00:00', '2020-12-28 23:17:24+00:00', 333302050, '2021-08-24 18:58:08+00:00', 'ajjl', '3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -929383517, -2090240067, '2022-11-13 09:18:31+00:00', -1278087274, -1140595602, 'wzw', 2, '2024-02-22 07:15:08+00:00', 'h', '9mo7', -354292049, 238533676, -1514700303, 1, '2020-09-11 00:02:55+00:00', '2021-12-11 06:40:50+00:00', -1793230843, '2022-07-09 16:59:45+00:00', 'do2zobb', 'q0k32od');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -2140468103, 469838697, '2025-09-08 01:16:35+00:00', -2076274980, 1731324803, 'wii1', 5, '2023-05-07 14:15:39+00:00', 'nxih662q', 'xlyotow9', 727608179, 456034296, -628433041, 3, '2024-09-22 16:04:20+00:00', '2024-05-20 15:01:09+00:00', 1044710644, '2022-03-05 18:43:06+00:00', '0', 'bindz');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -1934709172, -2121397544, '2024-02-16 12:52:03+00:00', 729449685, -1580984044, '8ri2hy0', 6, '2025-01-05 20:14:57+00:00', 'ftp6ewtqx', 'njabym', 1528227252, -1277305894, -1659775598, 5, '2023-11-11 00:49:07+00:00', '2022-01-25 01:36:36+00:00', 63063873, '2022-08-01 13:51:03+00:00', '1cj8', 'h5knz');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -1260548409, 1409697108, '2024-11-06 01:26:20+00:00', 833568923, -384749431, 'm', 7, '2025-02-20 13:44:44+00:00', 'qtgel', 'u', 422046500, -1750715330, 277649518, 6, '2020-04-14 17:03:31+00:00', '2022-09-09 18:35:07+00:00', -1414362698, '2022-02-26 17:54:28+00:00', '1quik1yhb08h', 'st1');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 1446366856, 438933248, '2024-07-30 17:06:35+00:00', 180947503, -622923312, 'dbdh', 8, '2022-07-31 04:43:08+00:00', 'j47nxar50', 'sj', -1652411404, -553121210, 1720208360, 1, '2022-10-01 02:03:07+00:00', '2021-10-15 14:48:39+00:00', 1492264835, '2022-12-24 15:58:16+00:00', 'qrlawk', '14r5dqt');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, -1599077491, 1589523321, '2025-05-31 15:54:26+00:00', -471198540, 1394459557, 'jwpp', 9, '2023-09-29 04:33:18+00:00', 'mb3aj0ju0', '3r', -167036460, -987989989, -2103849024, 2, '2023-04-17 12:54:33+00:00', '2023-03-26 03:13:54+00:00', -1617977597, '2025-05-23 04:48:20+00:00', 'l2i9esap8p', 'gckqwtsr54');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 906349223, 1200703349, '2024-06-20 05:23:42+00:00', -1415215611, -251621840, 'y1ogyv1rgeza', 10, '2025-02-02 10:57:02+00:00', 'c1clup', 'ly', 139907579, 914471233, -1813651479, 6, '2021-07-28 02:08:22+00:00', '2022-01-15 16:13:28+00:00', -1839279753, '2025-08-12 08:45:57+00:00', '9cy7od0', '3dlhdsvn');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, -1722214030, 1361395061, '2020-07-15 02:09:47+00:00', -696200137, -410809407, 'u49', 11, '2021-05-12 18:37:33+00:00', 'boe8cd', '4u', 426006253, 1097428449, -712974538, 1, '2022-01-01 15:24:37+00:00', '2022-09-24 18:37:16+00:00', -681356377, '2020-08-05 17:06:11+00:00', 'u', 'y9v2z12983');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (12, 1795932554, -831032281, '2024-12-02 01:38:56+00:00', -1652058172, 1509710997, 'm', 12, '2025-03-05 03:19:37+00:00', 'vb7vpc0xffw', 'r1es', 2056318381, 1749319777, -213453775, 11, '2020-11-04 04:29:53+00:00', '2023-06-26 05:39:29+00:00', -314024594, '2022-09-11 15:25:07+00:00', 'j7f', '8kqhiu5gm8');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (13, -29488259, -1767802623, '2023-09-16 19:46:29+00:00', -813616969, -1003698590, 'ok', 13, '2022-11-01 08:55:43+00:00', 'e6', 'ltut6', 1143458360, -769244829, 479662575, 1, '2020-07-16 02:15:44+00:00', '2025-10-18 23:03:37+00:00', -1637627413, '2020-05-17 03:39:19+00:00', 'mn5', 'ni');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'Community', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 1119186446, '2025-01-09 01:18:18+00:00', 'Community', '2022-05-20 13:35:30+00:00', 'qrofqyp5s5b', 'p', '02eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, '9hl7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -1438850342, '2020-08-18 16:30:34+00:00', 'x14ji7zwau2d', '2023-01-13 04:58:30+00:00', 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 556727997, 1178000634, 1836127587, -1529584866, 1196308825, 'd21vy9uxj4hw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -761353513, '2024-12-20 13:57:16+00:00', 'Community', '2022-07-15 04:16:04+00:00', 'mu2ne578lf', 'yz7zzb', '8y', -705922211, 1043710187, 318331233, -233617564, 79330142, '58b4pm');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -1177989415, '2021-07-28 17:39:51+00:00', 'Community', '2023-01-20 18:10:08+00:00', 'ngc1dj9', 'rh', 'izgk1yoeyo6', -360096930, -1942581013, -795975227, 1294064538, 778835680, 'kb521gw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -1275298282, '2020-04-18 15:13:13+00:00', 'Community', '2025-11-17 06:38:18+00:00', '3tdu6bd0w9', '03vzxw1rx', '9y', -1046720861, 643589729, -1231488097, 956819642, 774922170, '3dohvu0');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -2008781089, '2024-07-16 00:46:06+00:00', 'Community', '2022-02-28 07:00:33+00:00', 'ta8y3a17v4', 'ygmayq3qdpu', 'p', -845136979, -1042976410, -1670945624, 555368535, -1369148652, '7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -1043357093, '2022-10-05 16:38:36+00:00', 'Community', '2020-06-26 14:04:44+00:00', 'ftb8r9114', 'bre6b', 'jeuuwsj8kj', -55270062, -1101814296, 1939337883, -996196097, 986268139, 'urz0kaqtncg');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, -261782899, '2022-02-11 21:53:49+00:00', 'Community', '2021-04-12 10:48:20+00:00', 'ddlysu6ip', 'dk', 'u2gir31vwq5', -299585625, -2014514218, -1184608964, 1994296595, -1971610898, 'wnyqrouirlrp');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 886926141, '2024-11-01 13:21:55+00:00', 'Community', '2021-03-31 09:08:20+00:00', 'wns', '47j2ja8dccy3', 'vjwq49yrnx', 1511946366, -1910754958, -1900450199, -232312083, 1805923837, 'plj9fj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 1032462616, '2023-12-09 00:20:37+00:00', 'Community', '2023-12-02 03:42:48+00:00', 'spxpw30', 'g', 'kxginl', 1595944351, 1673977398, 1004962990, -1318740197, -306339789, 'o3ak162o');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, -1963064871, '2024-09-29 01:42:51+00:00', 'Community', '2024-04-08 16:08:53+00:00', 'iyet8x', 'hcf', '6cfperxa', -329270684, -1517724233, -1265768652, 2081562124, -1879135081, 'okuez');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, -1101370596, '2021-05-27 07:08:56+00:00', 'Community', '2022-12-29 10:22:55+00:00', '3hl', 'j43y795yb', '83kr3w', 1347243533, 1099005231, -1213283783, 1424689173, 1847608594, '9xgjjacgmukf');

-- Inserting into table: tags --
INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483648, 'r', 757448742, 1, -1179823637);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483647, 'tag_ed4e60', 1919033056, -2147483644, -1428186898);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (2, 'l', 895277769, 3, 364043263);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (3, 'tajz9td8n', -625404808, 5, -1694533100);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (4, '7dyyd', 357443379, 4, -1502591405);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (5, 'qomiztvb6m', -74691962, -2147483645, -2128972904);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (6, 'g97a', -1019350771, -2147483644, -225571092);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (7, 'qjektb1d2', -460035045, -2147483645, 1794943626);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (8, 'd2', -1066046077, 2, 972991637);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (9, 'xoepacxd', -2062902911, 9, -1809620481);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (10, 'b5qjls', -2086261320, 2, 1540741724);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (11, 'fmbgz5o', -1023455371, -2147483644, 1775901296);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T3.TagName = 'r', 1, 0)) AS REAL) * 100 / COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN tags AS T3 ON T3.ExcerptPostId = T2.PostId WHERE T1.DisplayName = 'Community';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN "tags"."tagname" = 'r' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT("posts"."id") AS percentage FROM "posts" INNER JOIN "users" ON "posts"."owneruserid" = "users"."id" INNER JOIN "tags" ON "posts"."tags" LIKE '%' || "tags"."tagname" || '%' WHERE "users"."displayname" = 'Community';

/*
Prediction Result:
(42.857142857142854,)
*/