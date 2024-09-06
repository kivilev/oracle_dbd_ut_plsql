package ru.oracle_dbd;

public class MainApp {

    public static void main(String[] args) {
        CountryTax countryTax = new CountryTaxInMemory();
        TaxCalculator taxCalculator = new TaxCalculator(countryTax);

        double result = taxCalculator.calculate(100d, Country.RU);
        System.out.println(result);
    }
}
