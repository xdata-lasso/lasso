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
-- DATASET 1
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (1, 100, '2009-01-01 00:00:00', 'Alice');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (2, 200, '2009-01-02 00:00:00', 'Bob');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (3, 300, '2009-01-03 00:00:00', 'Charlie');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (1, 1, 'Student', '2010-05-15 10:20:30');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (2, 1, 'Student', '2011-03-10 08:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (3, 2, 'Student', '2011-07-22 14:15:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (4, 3, 'Student', '2011-11-01 19:45:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (5, 1, 'Student', '2009-12-31 23:59:59');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (6, 2, 'Student', '2012-01-01 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (7, 3, 'Student', '2013-06-15 12:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (8, 1, 'Teacher', '2010-02-10 09:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (9, 2, 'Teacher', '2010-08-19 11:30:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (10, 3, 'Scholar', '2011-04-05 16:20:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(STRFTIME('%Y', Date) = '2010', 1, 0)) AS REAL) * 100 / COUNT(Id) - CAST(SUM(IIF(STRFTIME('%Y', Date) = '2011', 1, 0)) AS REAL) * 100 / COUNT(Id) FROM badges WHERE Name = 'Student';

/*
Gold Result:
(-28.57142857142857,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN STRFTIME('%Y', T1.Date) = '2010' THEN 1 ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', T1.Date) = '2011' THEN 1 ELSE 0 END)) * 100.0 / (SUM(CASE WHEN STRFTIME('%Y', T1.Date) = '2011' THEN 1 ELSE 0 END)) AS PercentageDifference FROM badges AS T1 WHERE T1.Name = 'Student';

/*
Prediction Result:
(-66.66666666666667,)
*/