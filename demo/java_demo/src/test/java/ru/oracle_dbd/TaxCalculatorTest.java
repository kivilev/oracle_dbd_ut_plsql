package ru.oracle_dbd;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class TaxCalculatorTest {

    private final CountryTax countryTax = new CountryTaxInMemory();
    private final TaxCalculator taxCalculator = new TaxCalculator(countryTax);

    // Позитивный кейс - Страна есть
    @Test
    public void calculateTaxWithExistedTaxShouldBeCorrect() {
        double income = 100d;
        double expectedValue = 16d;
        Country countryWithDefinedTax = Country.RU;

        double actualValue = taxCalculator.calculate(income, countryWithDefinedTax);

        assertEquals(expectedValue, actualValue);
    }

    // Негативный кейс - страны нет, НДС не задан
    @Test
    public void calculateTaxWithNotExistedCountryTaxShouldThrowException() {
        double income = 100d;
        Country countryWithoutDefinedTax = Country.KZ;
        String expectedErrorMessage = String.format("Tax is not defined for country with code: %s", countryWithoutDefinedTax.name());

        RuntimeException actualException = assertThrows(
                RuntimeException.class,
                () -> taxCalculator.calculate(income, countryWithoutDefinedTax)
        );

        assertEquals(expectedErrorMessage, actualException.getMessage());
    }

    // Негативный кейс - отрицательная сумма к расчету налога
    @Test
    public void calculateTaxWithNegativeValueShouldThrowException() {
        double income = -2;
        Country country = Country.RU;
        String expectedErrorMessage = "Value for tax calculation can not be negative";

        RuntimeException actualException = assertThrows(
                RuntimeException.class,
                () -> taxCalculator.calculate(income, country)
        );

        assertEquals(expectedErrorMessage, actualException.getMessage());
    }
}