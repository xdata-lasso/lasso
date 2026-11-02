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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (0, 1, NULL, NULL, NULL, 'default2', 'Teacher', 'default2', NULL, 99, 1, 100, 99, NULL), (99, NULL, NULL, 'Teacher', NULL, 'Teacher', NULL, NULL, 101, NULL, 101, 99, 99, 'default1'), (101, NULL, NULL, 'default2', '2023-01-01 00:00:00.000000', NULL, 'Teacher', 'default1', 100, 101, NULL, 99, 99, 'Teacher'), (100, NULL, '2023-01-01 00:00:00.000000', 'default2', NULL, 'default1', 'default1', 'default2', 1, 0, 1, NULL, 100, 'Teacher'), (1, 99, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', NULL, 'default1', 'default2', 1, 1, 100, 99, NULL, 'Teacher'), (2, 99, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', NULL, NULL, 'Teacher', 101, 0, 1, 1, NULL, NULL), (3, 99, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', 'Teacher', 'default2', 'Teacher', 100, 101, 0, NULL, 0, 'default2'), (4, 0, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', NULL, 'Teacher', 'Teacher', 100, 1, NULL, NULL, NULL, 'default1'), (5, NULL, '2023-01-01 01:00:00.000000', 'default2', NULL, 'default1', 'Teacher', NULL, 1, 0, 99, 0, 101, 'default2'), (6, 100, NULL, 'default2', '2023-01-01 01:00:00.000000', 'default2', NULL, 'default1', 0, 101, 1, 101, NULL, NULL), (7, 99, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', NULL, 'default2', 'Teacher', 99, 0, 101, 101, 1, 'default2'), (8, 100, '2023-01-01 00:00:00.000000', 'Teacher', NULL, NULL, NULL, 'default2', NULL, 1, NULL, 1, 101, 'default2'), (9, 100, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'Teacher', NULL, NULL, 0, 1, NULL, 101, NULL, 'default1'), (10, 100, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'Teacher', 'Teacher', 'Teacher', 99, NULL, 0, 101, 0, NULL), (11, 0, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'Teacher', 'default2', 'default2', 0, 101, 0, 1, NULL, NULL);
INSERT INTO badges (id, userid, name, date) VALUES (0, 11, 'default1', NULL), (100, 8, NULL, NULL), (99, 11, 'default1', NULL), (1, 2, 'default1', '2023-01-01 01:00:00.000000'), (101, 3, 'default1', NULL), (2, 8, 'Teacher', '2023-01-01 01:00:00.000000'), (3, 4, 'default1', '2023-01-01 00:00:00.000000'), (4, 0, 'default1', NULL), (5, 10, 'Teacher', '2023-01-01 01:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T1.Id) AS REAL) * 100 / (SELECT COUNT(Id) FROM users) FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T2.Name = 'Teacher';

/*
Gold Result:
(13.333333333333334,)
*/

-- Prediction Query
SELECT (COUNT(CASE WHEN b.Name = 'Teacher' THEN b.UserId END)) * 100.0 / COUNT(u.Id) AS TeacherPercentage FROM badges AS b INNER JOIN users AS u ON b.UserId = u.Id;

/*
Prediction Result:
(22.22222222222222,)
*/