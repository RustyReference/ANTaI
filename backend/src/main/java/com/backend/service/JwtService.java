package com.backend.service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

import io.jsonwebtoken.Jwts;

import javax.crypto.SecretKey;

@Component
public class JwtService {
    public static final String SECRET = "5367566859703373367639792F423F452848284D6251655468576D5A71347437";

    private SecretKey getSigningKey() {
        byte[] keyBytes = Decoders.BASE64.decode(SECRET);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    public String generateToken(String username) {
        Map<String, Object> claims = new HashMap<>();
        Date now = new Date();
        Date exp = new Date(now.getTime() + 1000 * 60 * 30);

        return Jwts.builder()
                .claims(new HashMap<String, Object>())
                .subject(username)
                .issuedAt(now)
                .expiration(exp)
                .signWith(getSigningKey())   // algorithm inferred
                .compact();
    }

    private Claims extractAllClaims(String token) {
        return Jwts.parser()
                .verifyWith(getSigningKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    /**
     * Extract all claims from the JWT payload
     * @param token the JWT as JWS
     * @param resolver the method that extracts a specific claim (i.e. which key:value are we extracting)
     * @return the specific claim as selected by resolver.
     * @param <T> The data type of the claim's value
     */
    public <T> T extractClaim(String token, Function<Claims, T> resolver) {
        // Extract all claims from the JWT payload, which is inside the JWS 'token'
        Claims claims = extractAllClaims(token);
        return resolver.apply(claims);
    }

    /**
     * @param token the JWT as JWS
     * @return the username stored in the payload, which is the subject
     */
    public String extractUsername(String token) {
        return extractClaim(token, Claims::getSubject);
    }

    /**
     * @param token the JWT as JWS
     * @return the expiration time/date of the token
     */
    public Date extractExpiration(String token) {
        return extractClaim(token, Claims::getExpiration);
    }

    /**
     * @param token the JWT as JWS
     * @return true if the JWT token is expired; false otherwise
     */
    public boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }

    /**
     * @param token the JWT as JWS
     * @param userDetails details of the user
     * @return true if the username in the JWT is the same as the user's username and their token is not expired
     */
    public boolean validateToken(String token, UserDetails userDetails) {
        String username = extractUsername(token);
        return username.equals(userDetails.getUsername()) && !isTokenExpired(token);
    }
}
