package com.backend.dto;

public record LoginRequest (
    String email,
    String password
) {}
