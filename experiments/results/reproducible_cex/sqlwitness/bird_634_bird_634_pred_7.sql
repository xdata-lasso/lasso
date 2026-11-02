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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (2, 1, '2023-01-01 00:00:00.000000', 'Harvey Motulsky', NULL, 'default2', 'Harvey Motulsky', NULL, 2, 0, NULL, NULL, 0, 'default1'), (0, NULL, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'Noah Snyder', 'Harvey Motulsky', 'Noah Snyder', NULL, 2, 1, 0, 1, 'Noah Snyder'), (1, NULL, '2023-01-01 00:00:00.000000', 'Noah Snyder', '2023-01-01 00:00:00.000000', 'Noah Snyder', 'Harvey Motulsky', 'default2', 0, 2, 2, 0, 1, 'Harvey Motulsky'), (3, 0, '2023-01-01 01:00:00.000000', 'Noah Snyder', NULL, 'default2', 'Harvey Motulsky', NULL, 1, 1, NULL, 2, 1, 'Noah Snyder');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (0, 3, 3, NULL, 2, '2023-01-01 00:00:00.000000', 0, 0, 'Harvey Motulsky', '2023-01-01 00:00:00.000000', 'Noah Snyder', 'default1', NULL, NULL, NULL, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 2, '2023-01-01 00:00:00.000000', 'default1', NULL), (2, 1, 0, NULL, 1, '2023-01-01 01:00:00.000000', 2, 1, 'Harvey Motulsky', NULL, 'default2', 'default1', 0, 0, 0, '2023-01-01 01:00:00.000000', NULL, 2, NULL, 'Noah Snyder', NULL);
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (0, NULL, NULL, 2, 'default1', '2023-01-01 00:00:00.000000', NULL, 'default1', 'Harvey Motulsky'), (2, 2, 2, 0, 'default2', '2023-01-01 00:00:00.000000', NULL, 'default1', 'Noah Snyder'), (1, 0, 2, 2, 'default2', '2023-01-01 00:00:00.000000', 'Harvey Motulsky', 'default2', 'Noah Snyder');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id WHERE T1.DisplayName = 'Harvey Motulsky' OR T1.DisplayName = 'Noah Snyder' GROUP BY T1.DisplayName ORDER BY SUM(T3.ViewCount) DESC, T1.DisplayName NULLS LAST LIMIT 1;

/*
Gold Result:
('Harvey Motulsky',)
*/

-- Prediction Query
SELECT t2.displayname, SUM(t1.viewcount) AS totalviewcount FROM posts AS t1 INNER JOIN users AS t2 ON t1.owneruserid = t2.id WHERE t2.displayname IN ('Harvey Motulsky', 'Noah Snyder') GROUP BY t2.displayname ORDER BY totalviewcount DESC, t2.displayname NULLS LAST LIMIT 1;

/*
Prediction Result:
('Noah Snyder', 0)
*/