create or replace package country_tax_service_pack is

  -- Author  : KIVIL
  -- Created : 03.09.2024 7:24:09
  -- Purpose : Сервис по работе с связкой "страна - налог"

  function get_country_tax(p_country_code countries.country_id%type)
    return country_tax.tax%type result_cache;
    
end country_tax_service_pack;
/
create or replace package body country_tax_service_pack is

  -- получаение налоговой ставки для страны
  function get_country_tax(p_country_code countries.country_id%type)
    return country_tax.tax%type result_cache is
    v_country_tax country_tax.tax%type;
  begin
    select max(t.tax)
      into v_country_tax
      from country_tax t
     where t.country_id = p_country_code;
  
    return v_country_tax;
  end;

end country_tax_service_pack;
/
