package ru.oracle_dbd;

import java.util.Optional;

public interface CountryTax {
    Optional<Double> getTax(Country country);
}
