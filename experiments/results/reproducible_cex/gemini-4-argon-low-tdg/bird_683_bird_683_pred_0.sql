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
-- Comprehensive mutant-killing dataset:
-- 1. Tests boundary condition T1.Reputation = 1000 vs > 1000
-- 2. Tests date condition: T2.CreaionDate in 2011 vs not 2011, and T1.CreationDate vs T2.CreaionDate
-- 3. Tests T2.LasActivityDate / T2.LastEditDate vs T2.CreaionDate
-- 4. Tests T2.OwnerUserId vs T2.LastEditorUserId vs T1.Id = T2.Id
-- 5. Tests COUNT(T1.Id) vs COUNT(DISTINCT T1.Id) (1 user having multiple posts)
-- 6. Tests INNER JOIN vs LEFT/RIGHT JOIN (unmatched users and unmatched posts with NULL OwnerUserId)
-- 7. Tests floating point division (CAST AS REAL) by ensuring 100 * numerator is not divisible by denominator (e.g., denominator = 7)
-- 8. Tests WHERE clause filtering vs conditional aggregation (IIF/CASE inside SUM)
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (1, 1001, '2010-01-01 10:00:00', 'User_Match_MultiPosts');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (2, 1000, '2011-05-05 10:00:00', 'User_Boundary_Rep_1000');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (3, 2000, '2011-06-06 10:00:00', 'User_HighRep_WrongPostYear');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (4, 500, '2011-07-07 10:00:00', 'User_LowRep_RightPostYear');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (5, NULL, '2011-08-08 10:00:00', 'User_NullRep');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (6, 5000, '2011-09-09 10:00:00', 'User_NoPosts');
-- Post 10: Matches both (Year=2011, Rep=1001)
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CreaionDate, LasActivityDate) VALUES (10, 1, 2, '2011-01-01 00:00:00', '2012-01-01 00:00:00');
-- Post 11: Same User 1, Matches both (Year=2011, Rep=1001) - tests DISTINCT user count & multiple matching rows
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CreaionDate, LasActivityDate) VALUES (11, 1, 2, '2011-12-31 23:59:59', '2012-01-01 00:00:00');
-- Post 12: Same User 1, Wrong Year (Year=2010, Rep=1001)
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CreaionDate, LasActivityDate) VALUES (12, 1, 1, '2010-12-31 23:59:59', '2011-05-05 00:00:00');
-- Post 13: Boundary Reputation = 1000, Right Year (Year=2011, Rep=1000) -> Should be 0
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CreaionDate, LasActivityDate) VALUES (13, 2, 1, '2011-06-15 12:00:00', '2011-06-15 12:00:00');
-- Post 14: High Rep (2000), Wrong Post Year (2012), but User CreationDate is 2011 and LasActivityDate is 2011 -> Should be 0
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CreaionDate, LasActivityDate) VALUES (14, 3, 1, '2012-01-01 00:00:00', '2011-06-06 10:00:00');
-- Post 15: Low Rep (500), Right Post Year (2011), LastEditorUserId has Rep > 1000 -> Should be 0
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CreaionDate, LasActivityDate) VALUES (15, 4, 1, '2011-03-03 00:00:00', '2011-03-03 00:00:00');
-- Post 16: Null Rep, Right Post Year (2011) -> Should be 0
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CreaionDate, LasActivityDate) VALUES (16, 5, 1, '2011-04-04 00:00:00', '2011-04-04 00:00:00');
-- Post 1: Id=1 (matches User 1 if joined on T1.Id = T2.Id), but OwnerUserId is NULL -> Excluded from INNER JOIN
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CreaionDate, LasActivityDate) VALUES (1, NULL, 1, '2011-08-08 00:00:00', '2011-08-08 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(STRFTIME('%Y', T2.CreaionDate) = '2011' AND T1.Reputation > 1000, 1, 0)) AS REAL) * 100 / COUNT(T1.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId;

/*
Gold Result:
(28.571428571428573,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN T2.Reputation > 1000 THEN 1 END) AS REAL) * 100 / COUNT(T1.Id) FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE STRFTIME('%Y', T1.CreaionDate) = '2011';

/*
Prediction Result:
(40.0,)
*/