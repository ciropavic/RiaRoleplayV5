

INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_karting','Karting',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_karting','Karting',1)
;

INSERT INTO `jobs` (name, label) VALUES
  ('karting','Karting')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('karting',0,'recrue','Employé',12,'{}','{}'),
  ('karting',1,'boss','Patron',24,'{}','{}')
;