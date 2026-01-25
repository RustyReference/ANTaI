package com.backend.controller;

import com.backend.dto.AuthResponse;
import com.backend.dto.LoginRequest;
import com.backend.dto.SignUpRequest;
import com.backend.model.User;
import com.backend.repository.UserRepository;
import com.backend.service.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/auth")
@RequiredArgsConstructor
@RestController
public class AuthController {

    private UserDetailsService userDetailsService;
    private JwtService jwtService;
    private AuthenticationManager authenticationManager;
    private UserRepository userRepository;

    @GetMapping("/test")
    public String test() {
        return "This is an test unsecured endpoint";
    }

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@RequestBody LoginRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.email(),
                        request.password()
                )
        );

        String token = jwtService.generateToken(request.email());

        return ResponseEntity.ok(new AuthResponse(token));
    }

    @PostMapping("/signup")
    public ResponseEntity<?> signup(@RequestBody SignUpRequest request) {
        if (userRepository.existsByEmail(request.email())) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body("Email already registered");
        }

        User user = new User();
        user.setEmail(request.email());
        user.setPassword(request.password());

        userRepository.save(user);

        String token = jwtService.generateToken(user.getEmail());

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(new AuthResponse(token));
    }
}
