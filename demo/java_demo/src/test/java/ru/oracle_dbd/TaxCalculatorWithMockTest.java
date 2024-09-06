package ru.oracle_dbd;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

class TaxCalculatorWithMockTest {

    private final CountryTax countryTax = Mockito.mock(CountryTax.class);
    private final TaxCalculator taxCalculator = new TaxCalculator(countryTax);

    @Test
    public void calculateTaxWithExistedTaxShouldBeCorrect() {
        double income = 100d;
        double expectedValue = 17d;
        Country countryWithDefinedTax = Country.RU;

        //ставим заглушку на метод, от которого зависим -> возвращаем то, что нам надо
        Mockito.when(countryTax.getTax(countryWithDefinedTax)).thenReturn(Optional.of(0.17d));

        double actualValue = taxCalculator.calculate(income, countryWithDefinedTax);

        assertEquals(expectedValue, actualValue);
    }

    @Test
    public void calculateTaxWithNotExistedCountryTaxShouldThrowException() {
        Country countryWithoutDefinedTax = Country.RU;
        String expectedErrorMessage = String.format("Tax is not defined for country with code: %s", countryWithoutDefinedTax.name());

        //ставим заглушку на метод, от которого зависим -> возвращаем то, что нам надо
        Mockito.when(countryTax.getTax(countryWithoutDefinedTax)).thenReturn(Optional.empty());

        RuntimeException actualException = assertThrows(
                RuntimeException.class,
                () -> taxCalculator.calculate(100, countryWithoutDefinedTax),
                "Expected RuntimeException to throw, but it didn't"
        );

        assertEquals(expectedErrorMessage, actualException.getMessage());
    }
}
