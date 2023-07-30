create or replace procedure delete_patient(
   p_code varchar(20) 
)
language plpgsql    
as $$
begin
	-- delete  service_dtl
    delete from service_dtl sd 
	where sd.service_id in (
		select sm.service_id from service_master sm 
		where sm.patient_id = (
			select p.patient_id  from patient p 
			where p.patient_code = p_code
			)
	);
	-- delete  service_master
    delete from service_master sm 
	where sm.patient_id = (
		select p.patient_id  from patient p 
		where p.patient_code = p_code
	);
	-- delete  patient
    delete from patient p 
	where p.patient_code = p_code; 

    

    commit;
end;$$

--call delete_patient('HH0900033124');
--drop procedure delete_patient(varchar(20));