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
-- Comprehensive dataset testing:
-- 1. Multiple badges for the same target user in 2011 (kills COUNT(DISTINCT T1.UserId), COUNT(DISTINCT T2.Id), COUNT(DISTINCT T1.Name), COUNT(DISTINCT T1.Date))
-- 2. Multiple users with DisplayName = 'csgillespie' (kills GROUP BY T2.Id or LIMIT 1 on user lookup)
-- 3. Boundary dates around 2011 and dates outside 2011 (kills <, <=, >, >=, BETWEEN mutants, missing date predicate, or using T2.CreationDate instead of T1.Date)
-- 4. Other users with badges in 2011, including badge Name = 'csgillespie' (kills missing DisplayName predicate, T1.Name = 'csgillespie', or cross join / wrong join condition like T1.Id = T2.Id)
-- 5. Badge with NULL UserId (kills RIGHT/LEFT JOIN and NULL handling errors)
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (1, 100, '2010-05-01 10:00:00', 'csgillespie');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (2, 200, '2011-05-01 10:00:00', 'other_user');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (3, 150, '2012-05-01 10:00:00', 'csgillespie');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (4, 300, '2011-06-01 10:00:00', 'csgillespie_extra');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (5, 400, '2011-07-01 10:00:00', 'CSGILLESPIE');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (10, 1, 'Teacher', '2011-01-01 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (11, 1, 'Teacher', '2011-01-01 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (12, 1, 'Editor', '2011-12-31 23:59:59');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (13, 3, 'Student', '2011-06-15 12:30:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (14, 1, 'Yearling', '2010-12-31 23:59:59');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (15, 1, 'Yearling', '2012-01-01 00:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (16, 1, 'Scholar', NULL);
INSERT INTO badges (Id, UserId, Name, Date) VALUES (1, 2, 'csgillespie', '2011-06-15 12:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (17, 4, 'Teacher', '2011-06-15 12:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (18, 5, 'Teacher', '2011-06-15 12:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (19, NULL, 'Teacher', '2011-06-15 12:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE STRFTIME('%Y', T1.Date) = '2011' AND T2.DisplayName = 'csgillespie';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM badges WHERE UserId = (SELECT Id FROM users WHERE DisplayName = 'csgillespie') AND STRFTIME('%Y', Date) = '2011';

/*
Prediction Result:
(3,)
*/