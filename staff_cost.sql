CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `staff_cost` AS
    SELECT 
        `r`.`date` AS `date`,
        `s`.`first_name` AS `first_name`,
        `s`.`last_name` AS `last_name`,
        `s`.`hourly_rate` AS `hourly_rate`,
        `sh`.`start_time` AS `start_time`,
        `sh`.`end_time` AS `end_time`,
        (((HOUR(TIMEDIFF(`sh`.`end_time`, `sh`.`start_time`)) * 60) + MINUTE(TIMEDIFF(`sh`.`end_time`, `sh`.`start_time`))) / 60) AS `hours_in_shift`,
        ((((HOUR(TIMEDIFF(`sh`.`end_time`, `sh`.`start_time`)) * 60) + MINUTE(TIMEDIFF(`sh`.`end_time`, `sh`.`start_time`))) / 60) * `s`.`hourly_rate`) AS `staff_cost`
    FROM
        ((`rota` `r`
        LEFT JOIN `staff` `s` ON ((`r`.`staff_id` = `s`.`staff_id`)))
        LEFT JOIN `shift` `sh` ON ((`r`.`shift_id` = `sh`.`shift_id`)))