package com.antai

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform