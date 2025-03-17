package com.example;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.OK)  // Ensures 200 OK status, even on errors
    public String handleAllExceptions(Exception ex) {
        return "Hello, World!";  // Return "Hello, World!" for any error
    }
}
