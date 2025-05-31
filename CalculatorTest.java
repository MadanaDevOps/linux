package com.example;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class CalculatorTest {
    Calculator calc = new Calculator();

    @Test
    void testAdd() {
        assertEquals(5, calc.add(2, 3));
    }

    @Test
    void testSubtract() {
        assertEquals(1, calc.subtract(4, 3));
    }

    @Test
    void testMultiply() {
        assertEquals(12, calc.multiply(4, 3));
    }

    @Test
    void testDivide() {
        assertEquals(3, calc.divide(9, 3));
    }

    @Test
    void testDivideByZero() {
        assertThrows(IllegalArgumentException.class, () -> calc.divide(5, 0));
    }

    @Test
    void testPower() {
        assertEquals(8, calc.power(2, 3));
    }
}

