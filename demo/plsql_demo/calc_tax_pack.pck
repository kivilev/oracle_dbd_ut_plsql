create or replace package calc_tax_pack is

  -- Author  : KIVIL
  -- Created : 02.09.2024 13:55:20
  -- Purpose : Демо пакет по расчету налоговой ставки

  -- коды ошибок
  c_value_error_code       constant number(10) := -20111;
  c_country_tax_error_code constant number(10) := -20110;


  -- функция по расчету налога по коду страны
  function calculate(p_value        number
                    ,p_country_code countries.country_id%type) return number;

end calc_tax_pack;
/
create or replace package body calc_tax_pack is

  -- функция по расчету налога по коду страны
  function calculate(p_value        number
                    ,p_country_code countries.country_id%type) return number is
    v_tax_value country_tax.tax%type;
  begin
    -- проверяем вх параметр, не дб отрицательным или null
    if p_value is null
       or p_value < 0 then
      raise_application_error(c_value_error_code,
                              'Value for tax calculation can not be negative');
    end if;
  
    -- получаем налоговую ставку для страны из сервиса
    v_tax_value := country_tax_service_pack.get_country_tax(p_country_code);
  
    -- если такой ставки для страны нет, то возбуждаем исключение
    if (v_tax_value is null) then
      raise_application_error(c_country_tax_error_code,
                              'Tax is not defined for country with code: ' ||
                              p_country_code);
    end if;
  
    -- рассчитываем и возвращаем
    return v_tax_value * p_value;
  end;

end calc_tax_pack;
/
