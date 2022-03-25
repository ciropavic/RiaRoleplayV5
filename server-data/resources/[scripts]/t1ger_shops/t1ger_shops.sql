INSERT INTO `jobs` (name, label) VALUES
	('shop', 'Shop');

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('shop',0,'apprentice','Apprentice',200,'{}','{}'),
	('shop',1,'clerk','Clerk',300,'{}','{}'),
	('shop',2,'boss','Owner',400,'{}','{}');

CREATE TABLE `t1ger_shops` (
	`identifier` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
	`shopID` INT(11),
	`money` INT(11) NOT NULL DEFAULT 0,
	`employees` longtext NOT NULL DEFAULT '[]',
	`stock` longtext NOT NULL DEFAULT '[]',
	`shelves` longtext NOT NULL DEFAULT '[]',
	PRIMARY KEY (`shopID`)
);

CREATE TABLE `t1ger_orders` (
	`id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`shopID` INT(11),
	`data` longtext NOT NULL DEFAULT '[]',
	`taken` INT(11) DEFAULT 0
);

