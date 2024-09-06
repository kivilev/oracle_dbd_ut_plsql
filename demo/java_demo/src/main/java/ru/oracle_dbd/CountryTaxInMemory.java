package ru.oracle_dbd;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

public class CountryTaxInMemory implements CountryTax {
    private final Map<Country, Double> taxCountries = new HashMap<>();

    public CountryTaxInMemory() {
        taxCountries.put(Country.RU, 0.16d);
        taxCountries.put(Country.US, 0.23d);
        // для KZ нет данных
    }

    public Optional<Double> getTax(Country country) {
        return Optional.ofNullable(taxCountries.getOrDefault(country, null));
    }
}
