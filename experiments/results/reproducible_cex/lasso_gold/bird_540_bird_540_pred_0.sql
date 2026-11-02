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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3391, 3395, '1993-02-15', 'csgillespie', '1997-06-19', 'http://www.nunez.info/', '376 Ann Street Apt. 314
Morrisshire, CO 15250', 'conference', 3399, 3403, 3407, 3411, 3415, 'https://www.pena-smith.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3393, 3400.0, '1993-02-16', 'csgillespie', '1997-06-20', 'http://www.roberts-foster.com/', '5355 Kayla Extension Suite 979
South Brady, GU 31104', 'as', 3418.0, 3424.0, 3430.0, 3436.0, 3442.0, 'https://smith.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3394, 3405.0, '1993-02-17', 'csgillespie', '1997-06-21', 'https://www.duncan-williams.biz/', '11039 Misty Viaduct Suite 051
Shannontown, MA 27896', 'federal', 3437.0, 3445.0, 3453.0, 3461.0, 3469.0, 'http://bray.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3459, 3410.0, '1993-02-18', 'csgillespie', '1997-06-22', 'https://www.shaw-ayala.com/', '88487 Heather Skyway
South Brandyhaven, AZ 33984', 'deep', 3456.0, 3466.0, 3476.0, 3486.0, 3496.0, 'http://www.mason.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3392, 3463, '1992-08-20', 'csgillespie', '1996-01-01', 'http://browning-murphy.net/', '056 Turner Summit
Edwinborough, CT 17742', 'else', 3467, 3471, 3475, 3479, 3483, 'http://hubbard.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3460, 3468.0, '1992-08-21', 'csgillespie', '1996-01-02', 'http://www.taylor.com/', '993 Jerry Burg Suite 172
Josephstad, HI 51286', 'natural', 3486.0, 3492.0, 3498.0, 3504.0, 3510.0, 'https://murray-henderson.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3461, 3473.0, '1992-08-22', 'csgillespie', '1996-01-03', 'https://www.forbes-daugherty.com/', '33060 Clements Forges
Port James, HI 58078', 'note', 3505.0, 3513.0, 3521.0, 3529.0, 3537.0, 'http://www.gallegos-hayes.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3462, 3478.0, '1992-08-23', 'csgillespie', '1996-01-04', 'http://grant.com/', '573 Sullivan Canyon Suite 569
New Danielmouth, GU 06060', 'individual', 3524.0, 3534.0, 3544.0, 3554.0, 3564.0, 'http://www.pace.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3451, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3519, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3420, 3423, 3427, '1971-05-05', 3431, 3542.0, 'game', 3391, '1975-09-09', 'Professor Emeritus', 'believe', 3439, 3443, 3447, 3451, '1979-02-13', '1983-06-17', 3455, '1987-10-21', 'Harold Garrett', 'Diana Hernandez');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3421, 3428.0, 3434.0, '1972-10-24', 3442.0, 3448.0, 'age', 3391, '1976-03-05', 'Industrial/product designer', 'size', 3464.0, 3470.0, 3476.0, 3451, '1980-07-09', '1984-11-13', 3492.0, '1988-04-17', 'William Mason', 'Mary Miller');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3422, 3433.0, 3441.0, '1972-10-25', 3453.0, 3461.0, 'among', 3391, '1976-03-06', 'Lecturer, further education', 'close', 3489.0, 3497.0, 3505.0, 3451, '1980-07-10', '1984-11-14', 3529.0, '1988-04-18', 'Lori Johns', 'Tyler Salazar');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3487, 3438.0, 3448.0, '1972-10-26', 3464.0, 3474.0, 'end', 3391, '1976-03-07', 'Recruitment consultant', 'affect', 3514.0, 3524.0, 3534.0, 3451, '1980-07-11', '1984-11-15', 3566.0, '1988-04-19', 'Robin Johnson', 'Crystal Allen');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3419, 3424, 3428, '1972-10-23', 3432, 3542.0, 'seem', 3392, '1976-03-04', 'Senior tax professional/tax inspector', 'increase', 3440, 3444, 3448, 3519, '1980-07-08', '1984-11-12', 3456, '1988-04-16', 'Rebecca Higgins', 'James Tate');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3488, 3496.0, 3502.0, '1971-05-06', 3510.0, 3516.0, 'little', 3392, '1975-09-10', 'Therapeutic radiographer', 'enough', 3532.0, 3538.0, 3544.0, 3519, '1979-02-14', '1983-06-18', 3560.0, '1987-10-22', 'Brian Cole', 'Krystal Keller');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3489, 3501.0, 3509.0, '1971-05-07', 3521.0, 3529.0, 'ago', 3392, '1975-09-11', 'Engineer, drilling', 'role', 3557.0, 3565.0, 3573.0, 3519, '1979-02-15', '1983-06-19', 3597.0, '1987-10-23', 'Joseph Cruz', 'Sean White');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3490, 3506.0, 3516.0, '1971-05-08', 3532.0, 3435, 'country', 3392, '1975-09-12', 'Programme researcher, broadcasting/film/video', 'range', 3582.0, 3592.0, 3602.0, 3519, '1979-02-16', '1983-06-20', 3634.0, '1987-10-24', 'Kayla Herring', 'Jennifer Collins');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Title FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T2.DisplayName = 'csgillespie' ORDER BY T1.ViewCount DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Senior tax professional/tax inspector',)
*/

-- Prediction Query
SELECT T2.Title FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE T1.DisplayName = 'csgillespie' ORDER BY T2.ViewCount DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Professor Emeritus',)
*/