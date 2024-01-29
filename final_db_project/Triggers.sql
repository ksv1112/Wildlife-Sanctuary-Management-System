-- 1.Trigger to prevent deletion of a sanctuary record if it is referenced by other tables
DELIMITER $$

CREATE TRIGGER prevent_sanctuary_deletion BEFORE DELETE ON Sanctuaries
FOR EACH ROW

BEGIN

  IF EXISTS(SELECT * FROM Animals WHERE SanctuaryID = OLD.SanctuaryID)
    OR EXISTS(SELECT * FROM Employees WHERE SanctuaryID = OLD.SanctuaryID)
    OR EXISTS(SELECT * FROM Doctors WHERE SanctuaryID = OLD.SanctuaryID)
    OR EXISTS(SELECT * FROM HabitatAreas WHERE SanctuaryID = OLD.SanctuaryID)
    OR EXISTS(SELECT * FROM Trees WHERE SanctuaryID = OLD.SanctuaryID)
    OR EXISTS(SELECT * FROM Birds WHERE SanctuaryID = OLD.SanctuaryID)
    OR EXISTS(SELECT * FROM SafariRideBookings WHERE SanctuaryID = OLD.SanctuaryID)
    OR EXISTS(SELECT * FROM Passengers WHERE SanctuaryID = OLD.SanctuaryID)
    OR EXISTS(SELECT * FROM MedicalSupplies WHERE SanctuaryID = OLD.SanctuaryID)
    OR EXISTS(SELECT * FROM FoodSupplies WHERE SanctuaryID = OLD.SanctuaryID)
  THEN
    SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Cannot delete sanctuary record because it is referenced by other tables';
  END IF;
END$$

DELIMITER ;

DELETE FROM Sanctuaries WHERE SanctuaryID = 5;

-- ----------------------------------------------------------------------------

SELECT * FROM FoodSupplies;


-- ---------------------------------------------------

-- 2. If a sanctuary has npre than 2 doctors then it will not alow to insert
DROP TRIGGER IF EXISTS check_Doctor_count;
DELIMITER $$

CREATE TRIGGER check_Doctor_count
AFTER INSERT ON Doctors
FOR EACH ROW
BEGIN

    DECLARE num_doctors INT;

    SELECT COUNT(*) INTO num_doctors
    FROM Doctors
    WHERE SanctuaryID = NEW.SanctuaryID;


    IF num_doctors > 2 THEN
       SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'There are more than 2 doctors working in this sanctuary.';
  END IF;
END$$

DELIMITER ;

INSERT INTO Doctors (FirstName, LastName, Specialization, SanctuaryID) VALUES 
('Peyush', 'Bansal', 'Zoo Veterinarian', 1);

-- -----------------------------------------------------------------

-- 3.DROP TRIGGER IF EXISTS check_medical_supplies;

DELIMITER $$

CREATE TRIGGER check_medical_supplies
AFTER INSERT ON Doctors
FOR EACH ROW
BEGIN

	 DECLARE total_cost INT;

    -- Calculate the total cost of medical supplies for the sanctuary that the new doctor works in
     SELECT SUM(CostPerUnit * Quantity) INTO total_cost
     FROM MedicalSupplies
     WHERE SanctuaryID = NEW.SanctuaryID;
     
      IF total_cost > 0.1 * (SELECT SUM(Salary) FROM Employees WHERE JobTitle = 'Veterinarian' AND SanctuaryID = NEW.SanctuaryID) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The total cost of medical supplies for this sanctuary is too high compared to the salaries of the doctors.';
     END IF;
END$$ 

DELIMITER ;

INSERT INTO Doctors (FirstName, LastName, Specialization, SanctuaryID) VALUES 
('Ajit', 'Pawar', 'Veterinarian', 1);



-- ---------------------------------------------------------

DELIMITER $$

CREATE TRIGGER update_salary AFTER INSERT ON Doctors
FOR EACH ROW
BEGIN
    UPDATE Employees SET Salary = Salary + 5000 WHERE JobTitle = 'Veterinarian';
END$$

DELIMITER ;

INSERT INTO Doctors (FirstName, LastName, Specialization, SanctuaryID) VALUES 
('Ajit', 'Pawar', 'Veterinarian', 1);


SELECT * FROM EMployees WHERE JobTitle = 'Veterinarian';


