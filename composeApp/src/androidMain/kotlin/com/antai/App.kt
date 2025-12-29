package com.antai

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.safeContentPadding
import androidx.compose.foundation.selection.selectable
import androidx.compose.foundation.selection.selectableGroup
import androidx.compose.material3.Button
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.RadioButton
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import org.jetbrains.compose.resources.painterResource
import org.jetbrains.compose.ui.tooling.preview.Preview

import antai.composeapp.generated.resources.Res
import antai.composeapp.generated.resources.compose_multiplatform
import org.intellij.lang.annotations.JdkConstants

@Composable
@Preview
fun App() {
    val navController = rememberNavController()

    NavHost(
        navController = navController,
        startDestination = "Home"
    ) {
        composable("Home") {
            HomeScreen(
                onGoToDetails = {
                    navController.navigate("Details")
                }
            )
        }
        composable("Details") {
            Details(
                onBack = {
                    navController.popBackStack()
                }
            )
        }
    }
}

@Composable
fun HomeScreen(onGoToDetails: () -> Unit) {
    var counter by remember {
        mutableIntStateOf(0)
    }

    MaterialTheme {
        Column(
            modifier = Modifier
                .fillMaxSize(),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            Text("Hello, world! This is the home screen")
            HorizontalDivider()
            Text(
                text = counter.toString(),
                fontSize = 40.sp
            )
            HorizontalDivider()

            Row {
                Button({ counter-- }) {
                    Text("-")
                }

                Button({ counter++ }) {
                    Text("+")
                }
            }

            Button(onClick = onGoToDetails) {
                Text("Navigate to Details")
            }
        }
    }
}

@Composable
fun Details(onBack: () -> Unit) {
    Column {
        RadioButtonSingleSelection()
    }
}

@Composable
fun RadioButtonSingleSelection(modifier: Modifier = Modifier) {
    val radioOptions = listOf("Calls", "Missed", "Friends")
    val (selectedOption, onOptionSelected) = remember { mutableStateOf(radioOptions[0]) }
    // Note that Modifier.selectableGroup() is essential to ensure correct accessibility behavior
    Column(
        modifier
            .selectableGroup()
            .fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center,
    ) {
         radioOptions.forEach { text ->
             Row(
                Modifier
                    .fillMaxWidth()
                    .height(56.dp)
                    .selectable(
                        selected = (text == selectedOption),
                        onClick = { onOptionSelected(text) },
                        role = Role.RadioButton
                    )
                    .padding(horizontal = 16.dp),
                verticalAlignment = Alignment.CenterVertically
             ) {
                 RadioButton(
                     selected = (text == selectedOption),
                     onClick = null // null recommended for accessibility with screen readers
                 )
                 Text(
                     text = text,
                     style = MaterialTheme.typography.bodyLarge,
                     modifier = Modifier.padding(start = 16.dp)
                 )
            }
        }
    }
}