INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_studio','studio',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_studio','studio',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_studio', 'studio', 1)
;

INSERT INTO `jobs` (`name`, `label`) VALUES
('studio', 'studio');


INSERT INTO `job_grades` (id, job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('90', 'studio',0,'recrue','Recrue',12,'{}','{}'),
	('91', 'studio',1,'novice','Novice',24,'{}','{}'),
	('92', 'studio',2,'experimente','Experimente',36,'{}','{}'),
	('93', 'studio',3,'chief',"Chef d\'équipe",48,'{}','{}'),
	('94', 'studio',4,'boss','Patron',0,'{}','{}')
;






