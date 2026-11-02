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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1619, 1623, '1990-11-23', 'Sherri Williamson', '1994-04-04', 'http://mitchell.net/', '814 Kathryn Groves
Whiteheadberg, MP 57841', 'purpose', 1627, 1631, 1635, 1639, 1643, 'http://www.carlson-smith.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1620, 1628.0, '1990-11-24', 'Brittany White', '1994-04-05', 'http://mckee-lee.org/', '5060 Shaw Freeway
Vangstad, IN 04195', 'student', 1646.0, 1652.0, 1658.0, 1664.0, 1670.0, 'http://www.patterson-mendez.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1621, 1633.0, '1990-11-25', 'Lori Orr', '1994-04-06', 'https://strickland-shaw.biz/', '522 Justin Village
Hortonberg, WV 92977', 'prevent', 1665.0, 1673.0, 1681.0, 1689.0, 1697.0, 'https://www.barnett.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1622, 1638.0, '1990-11-26', 'Amanda Diaz', '1994-04-07', 'http://www.taylor.com/', '04328 Rodriguez Heights
West David, IA 55528', 'lot', 1684.0, 1694.0, 1704.0, 1714.0, 1724.0, 'http://williams-hughes.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1687, 1691, '1989-06-05', 'Richard Glenn', '1993-10-09', 'https://adams.biz/', '8202 Johnson Cliff Apt. 556
New Ericmouth, MN 49261', 'economic', 1695, 1699, 1703, 1707, NULL, 'https://lara-arnold.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1688, 1696.0, '1989-06-06', 'Caleb Richardson', '1993-10-10', 'http://garcia-murphy.com/', '285 Edwards Harbors
North Anthony, HI 65911', 'street', 1714.0, 1720.0, 1726.0, 1732.0, NULL, 'http://www.sanders-love.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1689, 1701.0, '1989-06-07', 'Natalie Kline', '1993-10-11', 'https://robbins.info/', '4739 Benson Overpass
North Derek, CA 59751', 'minute', 1733.0, 1741.0, 1749.0, 1757.0, NULL, 'https://jones.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1690, 1706.0, '1989-06-08', 'William Crawford', '1993-10-12', 'http://bolton.com/', '55188 Vance Vista Apt. 258
North Tracie, WY 18703', 'agree', 1752.0, 1762.0, 1772.0, 1782.0, NULL, 'https://humphrey.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1679, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1743, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1647, 1651, 1655, '1998-08-08', 1659, 1663, 'environment', 1619, '1973-01-12', 'Broadcast journalist', 'sport', 1667, 1671, 1675, 1679, '1977-05-16', '1981-09-20', 1683, '1985-02-01', 'Andrew Payne', 'Edward Williams');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1648, 1656.0, 1662.0, '1998-08-09', 1670.0, 1676.0, 'small', 1619, '1973-01-13', 'Location manager', 'party', 1692.0, 1698.0, 1704.0, 1679, '1977-05-17', '1981-09-21', 1720.0, '1985-02-02', 'Carrie Maxwell', 'Andrew Mahoney');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1649, 1661.0, 1669.0, '1998-08-10', 1681.0, 1689.0, 'admit', 1619, '1973-01-14', 'Financial adviser', 'simple', 1717.0, 1725.0, 1733.0, 1679, '1977-05-18', '1981-09-22', 1757.0, '1985-02-03', 'Michael Welch', 'Virginia Daniels');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1650, 1666.0, 1676.0, '1998-08-11', 1692.0, 1702.0, 'heavy', 1619, '1973-01-15', 'Civil Service administrator', 'something', 1742.0, 1752.0, 1762.0, 1679, '1977-05-19', '1981-09-23', 1794.0, '1985-02-04', 'Amy Parsons', 'Paul Lee');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1711, 1715, 1719, '1997-03-13', 1723, 1727, 'court', 1687, '1972-07-17', 'Retail buyer', 'claim', 1731, 1735, 1739, 1743, '1976-11-21', '1980-04-02', 1747, '1984-08-06', 'Michael Reed', 'Caroline David');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1712, 1720.0, 1726.0, '1997-03-14', 1734.0, 1740.0, 'special', 1687, '1972-07-18', 'Automotive engineer', 'fly', 1756.0, 1762.0, 1768.0, 1743, '1976-11-22', '1980-04-03', 1784.0, '1984-08-07', 'Stephanie Singleton', 'Matthew Le');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1713, 1725.0, 1733.0, '1997-03-15', 1745.0, 1753.0, 'carry', 1687, '1972-07-19', 'Company secretary', 'community', 1781.0, 1789.0, 1797.0, 1743, '1976-11-23', '1980-04-04', 1821.0, '1984-08-08', 'Mark Pierce', 'Sarah Elliott');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1714, 1730.0, 1740.0, '1997-03-16', 1756.0, 1766.0, 'lead', 1687, '1972-07-20', 'Scientist, marine', 'color', 1806.0, 1816.0, 1826.0, 1743, '1976-11-24', '1980-04-05', 1858.0, '1984-08-09', 'Eric Ferguson', 'Alyssa Williams');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CreaionDate FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE NOT T1.Age IS NULL ORDER BY T1.Age, T2.CreaionDate, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('1998-08-08',)
*/

-- Prediction Query
SELECT T2.CreaionDate FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId ORDER BY T1.Age ASC, T2.CreaionDate ASC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('1997-03-13',)
*/