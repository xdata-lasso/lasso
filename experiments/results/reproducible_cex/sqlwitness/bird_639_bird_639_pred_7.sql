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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 2, '2023-01-01 01:00:00.000000', 'Community', '2023-01-01 00:00:00.000000', 'r|', '|r', 'default1', NULL, 2, 0, 1, 2, 'r'), (100, 2, '2023-01-01 01:00:00.000000', 'Community', '2023-01-01 00:00:00.000000', 'r|', 'r|', 'Community', 101, 101, 99, 0, 1, NULL), (2, 99, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'Community', '|r|', 'default2', 0, 0, 100, 0, NULL, 'Community'), (-1, 99, '2023-01-01 01:00:00.000000', '|r', '2023-01-01 00:00:00.000000', 'default2', 'Community', NULL, 100, 100, NULL, 99, NULL, '|r'), (101, 99, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', '|r|', 'default2', 'r|', 99, NULL, NULL, 1, -1, 'Community'), (0, NULL, '2023-01-01 01:00:00.000000', 'r', '2023-01-01 00:00:00.000000', '|r', 'default1', '|r|', 99, -1, NULL, 99, 2, 'r'), (99, 1, '2023-01-01 01:00:00.000000', 'default2', NULL, '|r', '|r', 'r', 0, 101, 101, 2, 2, 'default1'), (3, 101, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', '|r', 'default2', NULL, 101, 99, -1, 101, 2, '|r|'), (4, 0, '2023-01-01 01:00:00.000000', 'r|', NULL, NULL, '|r', 'r', NULL, 100, -1, 0, -1, 'Community');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (100, 101, 1, -1, 0, '2023-01-01 01:00:00.000000', NULL, 1, 'r', '2023-01-01 01:00:00.000000', 'r|', '|r', 99, 1, NULL, '2023-01-01 00:00:00.000000', NULL, 99, '2023-01-01 00:00:00.000000', 'default1', 'Community'), (99, 100, 4, -1, 99, '2023-01-01 00:00:00.000000', 2, 1, 'r|', '2023-01-01 00:00:00.000000', 'r', 'Community', 101, 101, 99, NULL, NULL, 100, '2023-01-01 00:00:00.000000', 'default2', 'default1'), (-1, 99, NULL, 1, -1, NULL, 0, 101, '|r|', '2023-01-01 01:00:00.000000', 'r|', 'r|', -1, 1, 101, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 99, NULL, '|r', 'r|');
INSERT INTO tags (id, excerptpostid, tagname, count, wikipostid) VALUES (2, -1, '|r', 99, -1), (101, NULL, 'default1', 1, NULL), (-1, 100, '|r', NULL, 2), (0, 99, 'r|', 100, 0), (1, 100, 'r|', 100, 1), (100, 99, 'default2', 99, 100);
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (0, NULL, NULL, 1, 'default1', '2023-01-01 00:00:00.000000', '|r|', NULL, '|r'), (101, 99, 99, 99, 'r', NULL, 'default2', NULL, '|r|'), (-1, 99, 3, 1, '|r|', NULL, 'default2', NULL, 'Community'), (2, -1, 101, -1, '|r|', NULL, 'default2', NULL, 'default1'), (1, -1, 2, 99, NULL, '2023-01-01 00:00:00.000000', 'Community', 'Community', 'Community'), (100, NULL, -1, NULL, 'default2', NULL, 'default2', 'default1', 'Community');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T3.TagName = 'r', 1, 0)) AS REAL) * 100 / COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN tags AS T3 ON T3.ExcerptPostId = T2.PostId WHERE T1.DisplayName = 'Community';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN INSTR(tags, '|r|') > 0 OR tags = 'r' OR INSTR(tags, 'r|') = 1 OR INSTR(tags, '|r') = LENGTH(tags) - 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) AS percentage FROM posts INNER JOIN users ON posts.owneruserid = users.id WHERE users.displayname = 'Community';

/*
Prediction Result:
(100.0,)
*/