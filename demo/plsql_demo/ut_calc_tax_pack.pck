create or replace package ut_calc_tax_pack is

  -- Author  : KIVIL
  -- Created : 02.09.2024 14:11:04
  -- Purpose : Unit-Тесты для функционала по расчету налогов

  -- %suite(Тестирование API для расчета налогов)

  ---- Позиитивные тест-кейсы

  -- 1. Вычисление налога для валидных входных параметров для существующей страны дб корректно
  --%test(Вычисление налога для валидных входных параметров для существующей страны дб корректно)
  procedure calculate_tax_with_existed_tax_should_be_correct;

  -- 2. Вычисление налога для суммы равной 0 дб корректно 
  --%test(Вычисление налога для суммы равной 0 дб корректно)
  procedure calculate_tax_with_zero_value_should_be_correct;


  ---- Негативные тест-кейсы

  -- 1. Вычисление налога для страны, для которой нет налоговой ставки должно завершаться ошибкой
  --%test(NEG. Вычисление налога для страны, для которой нет налоговой ставки должно завершаться ошибкой)
  --%throws(calc_tax_pack.c_country_tax_error_code)
  procedure calculate_tax_with_not_existed_country_should_throw_exception;

  -- 2. Вычисление налога для отрицательной суммы должно завершаться ошибкой
  --%test(NEG. Вычисление налога для отрицательной суммы должно завершаться ошибкой)
  --%throws(calc_tax_pack.c_value_error_code)
  procedure calculate_tax_with_negative_value_should_throw_exception;

  -- 3. Вычисление налога для null суммы должно завершаться ошибкой
  --%test(NEG. Вычисление налога для null суммы должно завершаться ошибкой)
  --%throws(calc_tax_pack.c_value_error_code)
  procedure calculate_tax_with_null_value_should_throw_exception;

end ut_calc_tax_pack;
/
create or replace package body ut_calc_tax_pack is

  c_ru_country_code          constant countries.country_id%type := 'RU';
  c_not_existed_country_code constant countries.country_id%type := 'XX';

  ---- Позиитивные тест-кейсы

  -- 1. Валидные входные параметры для существующей страны
  procedure calculate_tax_with_existed_tax_should_be_correct is
    v_actual_tax   number(38, 2); -- ФР
    v_expected_tax number(38, 2) := 17; -- ОР
    v_value        number(38, 2) := 100;
  begin
    -- ФР
    v_actual_tax := calc_tax_pack.calculate(p_value        => v_value,
                                            p_country_code => c_ru_country_code);
  
    -- проверяем ОР == ФР?
    ut.expect(a_actual => v_actual_tax).to_equal(v_expected_tax);
  end;

  -- 2. Вычисление налога для суммы равной 0
  procedure calculate_tax_with_zero_value_should_be_correct is
    v_actual_tax   number(38, 2); -- ФР
    v_expected_tax number(38, 2) := 0; --ОР
    v_zero_value   number(38, 2) := 0;
  begin
    v_actual_tax := calc_tax_pack.calculate(p_value        => v_zero_value,
                                            p_country_code => c_ru_country_code);
  
    ut.expect(a_actual => v_actual_tax).to_equal(v_expected_tax);
  end;




  ---- Негативные тест-кейсы

  -- 1. Вычисление налога для страны, для которой нет налоговой ставки должно завершаться ошибкой
  procedure calculate_tax_with_not_existed_country_should_throw_exception is
    v_actual_tax number(38, 2);
  begin
    -- ФР
    v_actual_tax := calc_tax_pack.calculate(p_value        => 100,
                                            p_country_code => c_not_existed_country_code);
  end;

  -- 2. Вычисление налога для отрицательной суммы должно завершаться ошибкой
  procedure calculate_tax_with_negative_value_should_throw_exception is
    v_actual_tax   number(38, 2); -- ФР
    v_negative_value   number(38, 2) := -1;
  begin
    v_actual_tax := calc_tax_pack.calculate(p_value        => v_negative_value,
                                            p_country_code => c_ru_country_code);
  end;

  -- 3. Вычисление налога для null суммы должно завершаться ошибкой
  procedure calculate_tax_with_null_value_should_throw_exception is
    v_actual_tax   number(38, 2); -- ФР
    v_negative_value   number(38, 2) := null;
  begin
    v_actual_tax := calc_tax_pack.calculate(p_value        => v_negative_value,
                                            p_country_code => c_ru_country_code);
  end;

end ut_calc_tax_pack;
/
