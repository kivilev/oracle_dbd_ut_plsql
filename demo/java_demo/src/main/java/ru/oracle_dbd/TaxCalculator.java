package ru.oracle_dbd;

import java.util.Optional;

public class TaxCalculator {

    private final CountryTax countryTax;

    public TaxCalculator(CountryTax countryTax) {
        this.countryTax = countryTax;
    }

    public double calculate(double value, Country country) {
        if (value < 0.0) {
            throw new RuntimeException("Value for tax calculation can not be negative");
        }

        // получаем налоговую ставку для указанной страны
        Optional<Double> countryTaxOptional = countryTax.getTax(country);

        // проверяем, задана ли ставка налога для этой страны. Если нет - возбуждаем исключение
        double tax = countryTaxOptional.orElseThrow(
                () -> new RuntimeException(String.format("Tax is not defined for country with code: %s", country.name()))
        );

        // считаем налог и возвращаем результат
        return value * tax;
    }
}
