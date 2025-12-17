use classicmodels;
delimiter $
create function calcular_percentual_perda_medio(product_code varchar(50))
returns decimal(10, 2)
deterministic
begin
    declare buy_price decimal(10, 2);
    declare msrp decimal(10, 2);
    declare percentual_perda decimal(10, 2);

    select 
		buyPrice,
        MSRP
    into
		buy_price,
        msrp
    from 
		products
    where 
		productCode = product_code;

    if msrp > 0 then
        set percentual_perda = ((msrp - buy_price) / msrp) * 100;
    else
        set percentual_perda = null;
    end if;

    return percentual_perda;
end$;
delimiter ;

select concat(calcular_percentual_perda_medio('S10_1678'), '%') as percentual_perda;