SET @job_name = 'lostmc';
SET @society_name = 'society_lostmc';
SET @job_Name_Caps = 'lostmc';



INSERT INTO `addon_account` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1),
  ('society_lostmc_fridge', 'lostmc (frigo)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `jobs` (name, label) VALUES
  (@job_name, @job_Name_Caps)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  (@job_name, 0, 'barman', 'Barman', 300, '{}', '{}'),
  (@job_name, 1, 'dancer', 'Danseur', 300, '{}', '{}'),
  (@job_name, 2, 'viceboss', 'Co-gérant', 500, '{}', '{}'),
  (@job_name, 3, 'boss', 'Gérant', 600, '{}', '{}')
;
