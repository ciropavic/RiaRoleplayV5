CREATE TABLE `t1ger_deliveryjob` (
	`identifier` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
	`companyID` INT(11),
	`name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT "Delivery Company",
	`level` INT(11) NOT NULL DEFAULT 0,
	`certificate` INT(11) NOT NULL DEFAULT 0,
	PRIMARY KEY (`companyID`)
);

