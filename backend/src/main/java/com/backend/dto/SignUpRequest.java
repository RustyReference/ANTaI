package com.backend.dto;

public record SignUpRequest(
        String email,
        String password
) {}
