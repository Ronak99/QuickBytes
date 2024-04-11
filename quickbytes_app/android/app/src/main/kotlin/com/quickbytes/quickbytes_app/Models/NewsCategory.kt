package com.quickbytes.quickbytes_app.Models

import kotlinx.serialization.Serializable

@Serializable
data class NewsCategory (
    val id: String,
    val name: String,
    val relevancy: String,
    val label: String,
)