package com.antai

import kotlin.random.Random

class Greeting {
    private val platform = getPlatform()

    fun greet(): List<String> = buildList {
        add(if (Random.nextBoolean()) "Hi" else "Hello")
        add("This is the platform: ${platform.name.reversed()}")
    }
}