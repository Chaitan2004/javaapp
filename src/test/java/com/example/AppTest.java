package com.example;

import static org.junit.Assert.*;
import org.junit.Test;

public class AppTest {
    @Test
    public void testApp() {
        App app = new App();
        assertEquals("Hello, World!", app.getMessage());
    }
}