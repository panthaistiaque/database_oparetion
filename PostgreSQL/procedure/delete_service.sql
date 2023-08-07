create or replace procedure delete_service(
   s_code varchar(20) 
)
language plpgsql    
as $$
begin
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