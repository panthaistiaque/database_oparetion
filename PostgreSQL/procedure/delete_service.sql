create or replace procedure delete_service(
   s_code varchar(20) 
)
language plpgsql    
as $$
begin

	-- -- -- -- -- -- -- 
	delete from service_execution_medication sem 
	where sem.service_id = (
		select sm.service_id from service_master sm where sm.service_code = s_code
	);
	-- -- -- -- -- -- -- 
	delete from service_diagnosis sd 
	where sd.service_id = (
		select sm.service_id from service_master sm where sm.service_code = s_code
	);
	-- -- -- -- -- -- -- 
	delete from service_investigation si  
	where si.service_id = (
		select sm.service_id from service_master sm where sm.service_code = s_code
	);
	-- -- -- -- -- -- -- 
	delete from service_execution_details sed 
	where sed.service_id = (
		select sm.service_id from service_master sm where sm.service_code = s_code
	);
	-- -- -- --- -- -- - - - 
	delete from service_execution se 
	where se.service_id = (
		select sm.service_id from service_master sm where sm.service_code = s_code
	);
	-- delete  refund_dtl
    delete from refund_dtl rd 
	where rd.refund_id in (
		select rm.refund_id from refund_master rm 
		where rm.trxn_ref_id = (select sm.service_id from service_master sm where sm.service_code = s_code)
	); 
	-- --- ---- ---- 
	delete from refund_master rm 
	where rm.trxn_ref_id = (
		select sm.service_id from service_master sm where sm.service_code = s_code
	);
    -- --- ---- ---- 
	delete from service_payment sp 
	where sp.payment_ref  = (
		select sm.service_id from service_master sm where sm.service_code = s_code
	);
	-- -- -- -- --- ----
	delete from service_dtl sd 
	where sd.service_id = (
		select sm.service_id from service_master sm where sm.service_code = s_code
	);
	-- -- -- -- -- -- -- -- -- 
	delete from service_master sm where sm.service_code = s_code;

    commit;
end;$$


--call delete_service('HH0900033124');
--drop procedure delete_service(varchar(20));